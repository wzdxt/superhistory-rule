# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  'use strict'

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

