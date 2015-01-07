# Jane
require 'sinatra'
require 'rufus-scheduler'
# require File.join(File.expand_path(File.dirname(__FILE__)), "addons", "sunset.rb")
# require File.join(File.expand_path(File.dirname(__FILE__)), "addons", "timer.rb")
require 'yaml'
require 'net/http'

require './lib/jane'

# listen to 0.0.0.0 instead of localhost
set :bind, '0.0.0.0'

helpers do
  def render_button(btn_desc)
    button_options = {
      class: "btn #{btn_desc[:btn_class]} btn-lg btn-block",
      onclick: "jane(#{btn_desc[:fn_args].map { |arg| "'#{arg}'" }.join(',')})"
    }
    icon_tag = "<span class=\"glyphicon glyphicon-#{btn_desc[:icon]}\"></span>"
    content = "#{icon_tag} #{btn_desc[:name]}"
    "<button #{button_options.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')}>#{content}</button>"
  end

  def render_category(category_hash)
    html_renderd_category =
    "<h3><span class=\"glyphicon glyphicon-#{category_hash[:icon]}\"></span>  #{category_hash[:title]}</h3>
    <div class=\"well\">\n"

    category_hash[:buttons].each do |button|
      html_renderd_category += render_button(button)
    end
    html_renderd_category += '</div>'
    # return html_renderd_category
  end
end

# render index.erb
get '/' do
  erb :index
end

config = Jane.config
config.each do |category|
  category[:buttons].each do |button|
    route = "/#{button[:fn_args].join('/')}"
    send(:get, route) do
      system button[:command]
    end
  end
end

# sunset inital cron entry
`cd /home/jarvis/Jane/ && whenever --update-cron`

# Timer
# timer(Time.now + 1 * 60, "Lampe aus")
