module ApplicationHelper
  def active_link_to text, path, html_options
    tmp = Rails.application.routes.recognize_path(path, method: html_options[:method])
    cssClass = params[:action] == tmp[:action] && params[:controller] == tmp[:controller] ? " active" : ""
    html_options[:class] = html_options[:class] + cssClass
    link_to text, path, html_options 
  end
end
