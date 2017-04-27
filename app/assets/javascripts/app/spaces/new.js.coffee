class mconf.NewSpaceForm
  @setup: ->
    $name = $("#space_name:not(.disabled)")
    $permalink = $("#space_permalink:not(.disabled)")
    $permalink.attr "value", mconf.Base.stringToSlug($permalink.val(), true)
    $permalink.on "input", () ->
      $permalink.val(mconf.Base.stringToSlug($permalink.val(), true))
    $permalink.on "blur", () ->
      $permalink.val(mconf.Base.stringToSlug($permalink.val(), false))
    $name.on "input keyup", () ->
      $permalink.attr "value", mconf.Base.stringToSlug($name.val())

$ ->
  if isOnPage 'spaces', 'new|create'
    mconf.NewSpaceForm.setup()
