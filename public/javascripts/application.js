var ThumbGallery = Class.create();

ThumbGallery.prototype = {
  initialize: function(element) {
    this.container = Element.extend(element);
    this.thumbs = this.container.select('img.thumb');
    this.size = this.thumbs.size();
    if(this.size > 0) {
      this.index = 0;
      this.height = this.container.getHeight();
      this.width = this.container.getWidth();
      
      this.thumbs.each(function(thumb) {
        Event.observe(thumb, 'load', this.resizeThumb.bindAsEventListener(this));
      }, this);
      // Event.observe(this.thumbs[0], 'load', this.resizeThumb.bindAsEventListener(this));
      Event.observe(this.container, 'mousemove', this.inspectMouse.bindAsEventListener(this));
      Event.observe(this.container, 'mouseout', this.reinit.bindAsEventListener(this));
      this.thumbs.first().show();
    }
  },
  inspectMouse: function(event){
    var column = (event.pointerX() - this.container.viewportOffset()['left'])/this.width;
    index = parseInt(column*this.size); 
    if(this.index != index) {
      this.thumbs[this.index].hide();
      this.index = index;
      this.thumbs[this.index].show();
    }
  },
  resizeThumb: function(event) {
    thumb = Event.element(event);
    var height = thumb.getHeight();
    var width = thumb.getWidth();
    if(height > width) {
      if(height > this.height) {
        var newWidth = this.height / height * width;
        thumb.setStyle({height: this.height + "px", width: newWidth + "px"});
      }
    }
    else {
      if(width > this.width) {
        var newHeight = this.width / width * height;
        thumb.setStyle({height: newHeight + "px", width: this.width + "px"});
      }
    }
  },
  reinit: function(event) {
    this.thumbs[this.index].hide();
    this.thumbs.first().show();
    this.index = 0;
  }
};

var Growl = Class.create();

Growl.prototype = {
  initialize: function() {
    
    Event.observe(document, 'growl:notify', this.notify.bindAsEventListener(this));
    
    this.container = document.createElement('div');
    Element.extend(this.container);
    this.container.addClassName('growl_container');
    
    document.body.appendChild(this.container);
  },
  notify: function(event) {
    var growler = document.createElement('div');
        var closeButton = document.createElement('button');
        var closeImage = document.createElement('img');
        
        Element.extend(growler);
        Element.extend(closeButton);
        Element.extend(closeImage);
        
        closeButton.addClassName('close');
            closeImage.writeAttribute({ src: '/images/close.png' });
            closeButton.insert(closeImage);
            closeButton.observe('click', function(event) { growler.remove(); });
            
            growler.identify();
            growler.addClassName('growl');
            growler.setStyle({ display: 'none' });
            growler.setOpacity(0.7);
            
            
            growler.insert(event.memo.message);
            growler.insert(closeButton);
            growler.appear({ duration: 2.0, from: 0.0, to: 0.7, queue: { position: 'end', scope: growler.id } });
            Element.fade.delay(10, growler, { duration: 2, from: 0.7, to: 0.0, queue: { position: 'end', scope: growler.id } });
            
            this.container.insert(growler, {position: 'bottom'});
  }
};


function manageDeleteIcon(element) {
  element = Element.extend(element);
  var div = element.ancestors().first();
  var deleteIcon = element.adjacent('.delete').first();
  div.observe('mouseover', function(event) { deleteIcon.show();  });
  div.observe('mouseout', function(event) {  deleteIcon.hide(); });
}

function insertGalleryToPage(request, id) {
  $('artist').update(request.responseText);
  new Effect.BlindDown('artist', { queue: { position: 'end', scope: 'contentscope' } });
}