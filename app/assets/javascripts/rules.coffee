# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require jstree/jstree

$ ->
  'use strict'

  source_dom = document.createElement('html')
  source_dom.innerHTML = $('#source').val()

  content_css_paths = []
  title_css_path = 'head title'

  Node = (tag = '', parent = null)->
    @tag = tag
    @target = null
    @children = []
    @parent = parent
    @toString = ->
      @print()
    @print = (tab = 0) ->
      out = ''
      blank = '';
      blank += ' ' for [0...tab]
      out += blank + @tag + '\n'
      out += node.print(tab + 2) for node in @children
      out
    @jstree_json = (prev_id, idx) ->
      id = if prev_id == undefined then 'j1' else "#{prev_id}_#{idx}"
      id: id
      text: @tag
      icon: false
      state:
        opened: false
      children: (child.jstree_json(id, idx + 1) for child, idx in @children)
    @

  build_dom_tree = (elem, parent) ->
    node = new Node(elem.prop('tagName'), parent)
    elem.children().each (idx, elem) ->
      node.children.push build_dom_tree($(elem), node)
    node


  # iframe
  $('#source_iframe').load ->
    $doc = $(@).contents()
    $('<style>').appendTo($doc.find('head')).attr('type', 'text/css')
    .text '''
    @-webkit-keyframes twinkling{
      50%{
        background-color: gray;
      }
    }
    .test-css-path {
      -webkit-animation: twinkling 2000ms infinite linear;
    }
    '''
    $doc.find('body').on 'click', (e) ->
      jstree_id = ''
      $(e.target).parents().slice(0, -1).each (idx, elem) ->
        jstree_id = $(elem).parent().children().index(elem) + 1 + '_' + jstree_id
      jstree_id = "j1_#{jstree_id}#{$(e.target).parent().children().index(e.target) + 1}"
      $('#jstree_div').jstree().deselect_all(true)
      $('#jstree_div').jstree().select_node(jstree_id)


  # path
  $('.form .url a.path-btn').each (idx, path_btn) ->
    $(path_btn).on 'click', ->
      $(".form .path .url-path input.path-pattern-item:eq(#{idx})").val path_btn.text
  # host
  $('.form .url a.host').on 'click', (e) ->
    $('#host_rule_host').val e.target.text
  # port
  $('.form .url a.port').on 'click', (e) ->
    $('#host_rule_port').val e.target.text
  # host ref id
  $('a.btn.remove-btn.remove-host-ref-id').on 'click', ->
    $('#host_rule_id').val ''
  # path all
  $('.form .path .url-path a.btn.path-all-btn').on 'click', (e)->
    $(e.target).siblings('input').val '[^\\/]+'
  # path digit
  $('.form .path .url-path a.btn.path-digit-btn').on 'click', (e)->
    $(e.target).siblings('input').val '\\d+'
  # head title
  $('.form .path .title-css-path a.btn.html-head-title-btn').on 'click', ->
    title_css_path = 'head title'
    $('.form .path .title-css-path input, input.css-path-input').val title_css_path
    $('.css-path-input').trigger('change')
  # set title
  $('a.btn.set-title-css-path-btn').on 'click', ->
    title_css_path = $('input.css-path-input').val()
    $('.form .path .title-css-path input').val title_css_path
  # set content
  $('a.btn.set-content-css-path-btn').on 'click', ->
    content_css_paths.push $('input.css-path-input').val()
    content_css_paths = content_css_paths.filter (path, idx) ->
      idx == content_css_paths.indexOf path
    render_content_css_paths_input()
  # test input
  $('.css-path-input').on 'change input', (e) ->
    selector = $(e.target).val()
    $('.input-path-preview').text $(selector, source_dom).text()
    $('#source_iframe').contents().find('.test-css-path').removeClass('test-css-path')
    $('#source_iframe').contents().find(selector).addClass('test-css-path')
  # all test
  $('a.test-btn').on 'click', ->
    $('div.input-path-preview').empty().append(
      $('<h1>').text $(title_css_path, source_dom).text()
    ).append(
      $(content_css_paths.join(','), source_dom)
    )
  # remove content path
  $('.content-css-paths-data ul').delegate 'li a.btn-remove', 'click', (e) ->
    content_css_paths.remove $(e.target).siblings('input').val()
    render_content_css_paths_input()


  # dom tree
  $ ->
    node = build_dom_tree($(source_dom))
    $('#jstree_div').jstree({
      core: {data: [node.jstree_json()]}
      plugins: ["wholerow"]
    }).on 'changed.jstree', (e, data) ->
      j_id = data.selected
      j_elem = $("##{j_id}")
      css_path = uniq_css_path(j_elem)
      j_elem.parents('[role=treeitem]').slice(0, -1).each (idx, elem) ->
        css_path = uniq_css_path(elem) + '>' + css_path
      $('.css-path-input').val(css_path).trigger('change')
    node

  # later functions
  render_content_css_paths_input = ->
    $('.content-css-paths-data ul').empty()
    $.each content_css_paths, (idx, path) ->
      $('.content-css-paths-data ul').append(
        $('<li>').append(
          $('<a>').attr('href', 'javascript:void(0)').addClass('btn btn-remove').text('x')
        ).append(
          $('<input>').attr('type', 'text').attr('name', 'path_rule[content_css_path_items][]').val(path).css('width', '500px')
        )
      )
  uniq_css_path = (elem, tagName) ->
    tagName = $(elem).find('a:eq(0)').text() if tagName == undefined
    idx = $(elem).parent().children().index(elem) + 1
    "#{tagName}:nth-child(#{idx})"






