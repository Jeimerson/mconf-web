# Notifications using toastr

defaultOpts =
  tapToDismiss: true
  # positionClass: 'toast-top-right'
  positionClass: 'toast-top-full-width'
  iconClass: ''
  hideMethod: 'slideUp'
  hideDuration: 200
  showMethod: 'slideDown'
  showDuration: 400
  closeButton: false

class mconf.Notification

  @bind: ->
    $("div[name='error']", "#notification-flashs").each ->
      showNotification(this, "error")
    $("div[name='alert'], div[name='warn']", "#notification-flashs").each ->
      showNotification(this, "warn")
    # notice messages are usually success messages in form updates, so consider them
    # always as success
    $("div[name='success'], div[name='notice']", "#notification-flashs").each ->
      showNotification(this, "success")

  # Adds a new notification of type `type` to the page.
  # `type` can be "success", "error", or "notice".
  # `text` is the message included inside the notification.
  # The notification is only added to the page but will *not* be displayed. To do so,
  # call `mconf.Notification.bind()`.
  @add: (type, text) ->
    notification = $("<div></div>")
    notification.attr("name", type)
    notification.html(text)
    $('#notification-flashs').append(notification)
    notification

  @addAndShow: (type, text) ->
    notification = @add(type, text)
    showNotification(notification, type)

showNotification = (target, type) ->
  $target = $(target)

  if _.isEmpty($target.text().trim())
    return

  unless $target.attr("data-notification-shown") is "1"
    $target.attr("data-notification-shown", "1")

    opts = {}
    switch type
      when "success"
        method = toastr.success
        opts = $.extend {}, defaultOpts,
          timeOut: 0
          extendedTimeOut: 5000
      when "error"
        method = toastr.error
        opts = $.extend {}, defaultOpts,
          force: true
          timeOut: 0
          extendedTimeOut: 5000
      when "warning", "warn", "alert"
        # method = toastr.warning
        method = toastr.error
        opts = $.extend {}, defaultOpts,
          force: true
          timeOut: 0
          extendedTimeOut: 5000

      # this should never happen, but leave it here so it shows a
      # weird notification when it happens and we can fix it
      else
        method = toastr.warning

    toastr.options = opts
    method mconf.Base.escapeHTML($target.text())

$ ->
  mconf.Notification.bind()
