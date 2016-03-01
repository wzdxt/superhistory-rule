# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require jstree/jstree

$ ->
  'use strict'

  source_dom = document.createElement('html')
  source_dom.innerHTML = $('#source').val()

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
    @jstree_json = ->
      text: @tag
      icon: false
      state:
        opened: true
      children: (child.jstree_json() for child in @children)
    @

  build_dom_tree = (elem, parent) ->
    node = new Node(elem.prop('tagName'), parent)
    elem.children().each (idx, elem) ->
      node.children.push build_dom_tree($(elem), node)
    node


  # iframe
  $('#source_iframe').load ->
    $('<style>').appendTo($(this).contents().find('head')).attr('type', 'text/css')
    .text '''
    @-webkit-keyframes twinkling{
      90%{
        background-color: gray;
      }
      100%{
        background-color: white;
      }
    }
    .test-css-path {
      -webkit-animation: twinkling 1000ms infinite ease-in-out;
    }
    '''


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
    $(e.target).prev().val '[^\\/]+'
  # head title
  $('.form .path .title-css-path a.btn.html-head-title-btn').on 'click', ->
    $('.form .path .title-css-path input, input.css-path-input').val 'head title'
    $('.css-path-input').trigger('change')
  # set title
  $('a.btn.set-title-css-path-btn').on 'click', ->
    $('.form .path .title-css-path input').val $('input.css-path-input').val()
  # test input
  $('.css-path-input').on 'change input', (e) ->
    selector = $(e.target).val()
    $('.input-path-preview').text $(selector, source_dom).text()
    $('#source_iframe').contents().find('.test-css-path').removeClass('test-css-path')
    $('#source_iframe').contents().find(selector).addClass('test-css-path')

  # dom tree
  $ ->
    uniq_css_path = (elem) ->
      $(elem).find('a:eq(0)').text()

    node = build_dom_tree($(source_dom))
    $('#jstree_div').jstree({
      core: {data: [node.jstree_json()]}
      plugins: ["wholerow"]
    }).on 'changed.jstree', (e, data) ->
      j_id = data.selected
      j_elem = $("##{j_id}")
      css_path = uniq_css_path(j_elem)
      j_elem.parents('[role=treeitem]').each (idx, elem) ->
        css_path = uniq_css_path(elem) + ' ' + css_path
      css_path = css_path.split(' ').slice(1).join('>')
      $('.css-path-input').val(css_path).trigger('change')
    node





