# Copyright 2008-2010 Universidad Politécnica de Madrid and Agora Systems S.A.
#
# This file is part of VCC (Virtual Conference Center).
#
# VCC is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# VCC is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with VCC.  If not, see <http://www.gnu.org/licenses/>.

class Agenda < ActiveRecord::Base
  belongs_to :event
  has_many :agenda_entries
  has_many :agenda_record_entries
  has_many :attachments, :through => :agenda_entries
  
  #acts_as_container :content => :agenda_entries
  #acts_as_content :reflection => :event

  def agenda_entries_for_day(i)
    all_entries = []
    for entry in agenda_entries
      if entry.start_time > (event.start_date + i.day).to_date && entry.start_time < (event.start_date + 1.day + i.day).to_date
        all_entries << entry
      end
    end
    all_entries.sort!{|a,b| a.start_time <=> b.start_time}
  end
  
end
