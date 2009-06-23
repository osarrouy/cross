# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def lazy_subheader(*args)
    options = args.extract_options!

    subheader = '<div class="subheader">'
    if options[:title]
      subheader << '<h3 class="subtitle">'
      subheader << options[:title]
      subheader << '</h3>'
    end
    subheader << '<ul class="submenu">'
    args.each do |link|
      link_options = link.last.class == Hash ? link.last : {} 
      subheader << '<li>'
      if link_options[:confirm]
        subheader << link_to(link.first, link[1], :method => :delete, :confirm => link_options[:confirm])
      else
        subheader << link_to(link.first, link[1])
      end
      subheader << '</li>'
    end
    subheader << '</ul>'
    subheader << '</div>'
    
    subheader
  end

  def lazy_field(object, attribute, *args, &proc)
    options = args.extract_options!
    
    singular_class_name = ActionController::RecordIdentifier.singular_class_name(object)
    plural_class_name = ActionController::RecordIdentifier.plural_class_name(object)
    
    id = "#{singular_class_name}_#{attribute}_field"

    content_tag(:div, lazy_attribute(object, attribute, options, &proc), :id => id)
    
  end
  
  def lazy_form(object, attribute, *args, &proc)
    options = args.extract_options!
    
    singular_class_name = ActionController::RecordIdentifier.singular_class_name(object)
    plural_class_name = ActionController::RecordIdentifier.plural_class_name(object)
    
    url = options.delete(:url) || url_for(:controller => plural_class_name, :action => 'update', :id => object.id, :format => :js)
    method = options.delete(:method) || :put
    id = options.delete(:id) || "#{singular_class_name}_#{attribute}_field"
    html = { :class => 'lazy_form' }.merge(options.delete(:html) || {})
    
   if block_given?
     input = proc.call(object)
    else
      input = input(singular_class_name, attribute)
    end

    field_id = "#{singular_class_name}_#{attribute}"
    
    form_for(object, :url => url, :method => method, :html => html) do |f|
      concat(input)
    end
    
    

    javascript_tag do
     concat("$('#{field_id}').focus();");
     concat("$('#{field_id}').observe('blur', function(event) { " + remote_function(:update => "#{field_id}_field", :url => url,
      :method => :put, :with => "$('#{field_id}').serialize(true)") + "});");
      concat("$('edit_#{singular_class_name}_#{object.id}').observe('submit', function(event) { " + remote_function(:update => "#{field_id}_field", :url => url,
        :method => :put, :with => "$('#{field_id}').serialize(true)") + "; event.stop();});")
    end
    
  end
  
  def lazy_attribute(object, attribute, *args, &proc)
    options = args.extract_options!
    
    singular_class_name = ActionController::RecordIdentifier.singular_class_name(object)
    plural_class_name = ActionController::RecordIdentifier.plural_class_name(object)
    
    url = options.delete(:url) || url_for(:controller => plural_class_name, :action => 'edit', :id => object.id, :format => :js)
    method = options.delete(:method) || :get
    options[:class] ||= "lazy_field"
    id = "#{singular_class_name}_#{attribute}_field"
    tag = options.delete(:tag) || :p
    
   if block_given?
      field = proc.call(object)
    else
      field = object.send(attribute)
    end
    
    content = content_tag(tag, field, options)
    updater = remote_function(:url => url, :method => method, :with => "'attribute=#{attribute}'", :update => id)
    script = "$('#{id}').firstDescendant().observe('click', function(event) {#{updater}})"
    
    content + content_tag(:script, script)
  end
  
  def lazy_photos(gallery)
    photos = ''
    gallery.photos.each do |photo|
      photos << '<div>'
      photos << link_to_remote(image_tag('delete.png', :class => 'delete', :style => "display: none"), :url => admin_gallery_photo_path(@gallery, photo, :js), :method => :delete, :update => 'gallery_photos_field')
      photos << image_tag(photo.image.url(:thumb), :id => photo.id, :class => 'thumb')
      photos << '<script type="text/javascript">'
      photos << "manageDeleteIcon($('#{photo.id}'));"
      photos << '</script>'
      photos << '</div>'
    end
    photos
  end
  
  def thumb_gallery(collection, options = {})
    
    id = options.delete(:id)
    title = content_tag(:p, options.delete(:title), :class => 'title') unless options[:title].blank?

    photos = "<div id='#{id}' class='thumb_gallery'>"
    if collection.blank?
      photos << '<p>Aucune photo</p>'
    else
      collection.each do |photo|
        photos << image_tag(photo.image.url(:medium), :class => 'thumb', :style => "display:none")
      end
    end
    photos << '</div>'
    
    if(options[:url])
      gallery = link_to(photos, options.delete(:url), :class => 'gallery')
    else
      gallery = photos
    end
    
    script = "<script type='text/javascript'>new ThumbGallery($('#{id}'));</script>"
    
    content = title + gallery + script
    
    content_tag(:div, content, :class => "thumb_gallery_wrapper")
    
  end
  
end
