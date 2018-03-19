# This file is part of Mconf-Web, a web application that provides access
# to the Mconf webconferencing system. Copyright (C) 2010-2015 Mconf.
#
# This file is licensed under the Affero General Public License version
# 3 or later. See the LICENSE file.

require 'version'

module CustomBigbluebuttonPlaybackTypesHelper
  include IconsHelper

  def link_to_playback(recording, playback, options={})
    link_params = { type: playback.format_type }

    if playback.identifier == 'presentation_video'
      name = if recording.description.blank?
               recording.name
             else
               recording.description
             end
      options.merge!(download: name.parameterize('_'))
      link_params.merge!(name: name.parameterize('_'))
    end

    if ['presentation_video'].include?(playback.identifier)
      playback_icon = icon_file_download
    elsif ['presentation_export'].include?(playback.identifier)
      playback_icon = icon_archive
    else
      playback_icon = icon_conference_play
    end

    link_to playback_icon, play_bigbluebutton_recording_path(recording, link_params),
            options_for_tooltip(t("bigbluebutton_rails.playback_types.#{playback.identifier}.tip"), options)
  end

end
