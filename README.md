# README

* I am not looping Organizations in the exercise, but I am looping Pipes (even though the API is returning only one Pipe)

* I decided to include only the columns that the fields had value on some card to make the screen cleaner. To include all fields, simply replace the lines below at app/views/home/index.html.erb

from:
<% phase_ids = cards.pluck(:phase_id).uniq %>
<% fields = Field.where(phase_id: phase_ids).order('id desc').pluck(:key, :name).uniq %>

to:
<% fields = Field.all.order('id desc').pluck(:key, :name).uniq %>
