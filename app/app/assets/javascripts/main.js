$(function() {
	// Temporarily disable links
	$('a').on('click', function(event) {
		if($(this).attr('href') == '#') {
			event.preventDefault();
		}
	});
	
	// Site Menu
	var $siteMenu = $('#site-menu'),
	$pageButton = $('#page-button'),
	$menuToggleButtons = $('.js-site-menu-toggle'),
	$cross = $('#cross'),
	$ybcologo = $('#ybcologo'),
	$main = $('#page-main');

	$menuToggleButtons.on('click', function() {
		$siteMenu.toggleClass('enabled');
		$pageButton.toggleClass('enabled');
		$ybcologo.toggleClass('enabled');
		$cross.toggleClass('enabled');
		$main.toggleClass('enabled');
	});

	// scrollTo Buttons
	var $scrollToButtons = $('.js-scrollto-button');

	$scrollToButtons.each(function() {
		var $this = $(this),
			target = $this.attr('data-scroll-target');

		if(target == 'next') {
			target = $this.closest('.js-page-section');
		}

		else if(!target) {
			target = 0;
		}

		$this.on('click', function(event) {
			event.preventDefault();
			$(window).scrollTo(target, 400);
		});
	});			

	// Pricing Plans
	var $pricingOpenButtons = $('.js-pricing-open');

	$pricingOpenButtons.each(function() {
		var $this = $(this),
			$plan = $this.parents('.js-pricing-plan'),
			$target = $plan.find('.pricing-plan-content');

		$this.on('click', function(event) {
			event.preventDefault();
			$target.slideDown(0, function() {
				$(window).scrollTo($plan, 400);
				$plan.find('.pricing-plan__link').hide();
			});
		});
	});

	var $pricingCloseButtons = $('.js-pricing-close');

	$pricingCloseButtons.each(function() {
		var $this = $(this),
			target = $this.parents('.js-pricing-plan');

		$this.on('click', function(event) {
			event.preventDefault();
			target.find('.pricing-plan__link').show();
			$(window).scrollTo(target, 0, function() {
				target.find('.pricing-plan-content').slideUp(0);
			});
		});
	});

	// Project navigation
	var $projectNavigation = $('#project-navigation'),
		$projectNavigationLinks = $projectNavigation.find('a');

	$projectNavigation.sticky({
		topSpacing: $('.banner-notice').outerHeight(true)
	});

	$projectNavigationLinks.each(function() {
		var $this = $(this),
			target = $this.attr('href');
			//alert(target);
			//alert(target.substring(1));

		$this.on('click', function(event) {
			event.preventDefault();
			$(window).scrollTo(target, 300);
		});

	// Waypoints
		var waypoint = new Waypoint({
			element: document.getElementById(target.substring(1)),
			offset: 70,
			handler: function(direction) {
				var _filter = '[href=' + target + ']';

				$siteMenu.removeClass('enabled');
				$pageButton.removeClass('enabled');
				$main.removeClass('enabled');
				$ybcologo.removeClass('enabled');
				$cross.removeClass('enabled');

				$projectNavigationLinks
					.parents('li')
					.removeClass('current');

				if(direction == 'down') {
					$projectNavigationLinks
					.filter(_filter)
					.parents('li')
					.addClass('current');
				}

				else {
					$projectNavigationLinks
					.filter(_filter)
					.parents('li')
					.prev()
					.addClass('current');
				}
			}
		});
	});

	// Form input select
	var $formInputSelects = $('.js-form-input-select');

	$formInputSelects.on('click', function() {
		$(this).siblings('select').css('visibility', 'visible');
	});

	$('.js-project-examples-content').hide();

	// Create Project: Examples button
	$('.js-project-examples-toggle').on('click', function() {
		$(this).toggleClass('enabled');
		$('.js-project-examples-content').slideToggle(0);
	});

	// Project fuel bars
	$('.js-project-fuel-bar').each(function() {
		var $this = $(this),
			fuel = $this.attr('data-fuel');

		if(parseInt(fuel) > 100) {
			fuel = '100%';
		}

		$this.css('width', fuel);
	});

	// Flickity
	$('#project-gallery').flickity({
		pageDots: false,
		wrapAround: true
	});

	 var flkty = $('#project-gallery').data('flickity');

	$('#project-gallery').on('cellSelect', function() {
		$('#project-gallery-counter__current').text(flkty.selectedIndex + 1);
		console.log($('#project-gallery-counter__current'));
	});

	// Textarea limits
	$('.js-textarea-limit').each(function() {
		var $this = $(this),
			textarea = $this.attr('data-for'),
			$textarea = $('#' + textarea),
			limit = $this.attr('data-limit'),
			$count = $this.find('.textarea-character-limit__count');

		$textarea.on('keyup', function() {
			$count.text(limit - $textarea.val().length);
		});
	});
	
	$(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
    	event.preventDefault();
    	$(this).ekkoLightbox();
	}); 

	// Lightbox
	var lightbox = $('.js-lightbox'),
		lightboxOverlay = $('.js-lightbox-overlay'),
		lightboxContent = $('.js-lightbox-content');

	function openLightbox(content) {
		lightboxContent.html(content);
		lightboxOverlay.fadeIn(200);
		lightbox.fadeIn(400);
	}

	function closeLightbox() {
		lightbox.fadeOut(200);
		lightboxOverlay.fadeOut(400, function() {
			lightboxContent.html('');
		});
	}

	$('.js-lightbox-open').on('click', function() {
		var $this = $(this),
			contentContainer = $($this.attr('data-content-container')),
			content = contentContainer.html();

		openLightbox(content);
	});

	$('.js-lightbox-close').on('click', function() {
		closeLightbox();
	});

	$('.js-lightbox-open-image').on('click', function() {
		var $this = $(this),
			contentContainer = $($this.attr('container')),
			content = contentContainer.html();

		openLightbox(content);
	});

	$('.js-lightbox-close-image').on('click', function() {
		closeLightbox();
	});

	$(document).keyup(function(e) {
		if (e.keyCode == 27) { // Escape
			closeLightbox();
		}
	});

	// Banner notice
	/*
	$('.banner-notice .js-close').on('click', function() {
		$(this).parents('.banner-notice').hide();
		$('.page-header').css('top', '2rem');
		$projectNavigation.css('top', '0').sticky({
			topSpacing: 0
		});
	});*/

	

    $(".dropdown-toggle").dropdown();
    $('#admin-project-proposal-table').DataTable();

    
    $(window).scroll(function(){
        if ($(this).scrollTop()>0){
        	//$('#banner').fadeOut();
        	//$('.banner-notice').fadeOut();
            	//$('.page-header').css('top', '1rem');
    			$projectNavigation.css('top', '0').sticky({
    				topSpacing: 0
				});
     	}
    });


    //THIS IS for the get started page to select the location
    $('#resizing_select').change(function(){
      $("#width_tmp_option").html($('#resizing_select option:selected').text()); 
      $(this).width($("#width_tmp_select").width());  
    });

    //THIS IS for the sortable function for the milestones
    var $component = 'Timeline';

	function sort() {
		var $itemIndex = 0;

		console.log('reorder');
		
		$('.' + $component).find('.' + $component + '-item').each(function(index) {

			index++;
			$itemIndex = (index < 10) ? '0' + index : index;
			
			$(this).find('.' + $component + '-item-index').text($itemIndex);

			if (index % 2 === 0) {
        $(this).addClass('is-right');
      }
      else {
        $(this).removeClass('is-right');
      }

		});
	}

	sort();

 	var el = document.getElementById($component);
  	var sortable = Sortable.create(el, {
    draggable: '.' + $component + "-item", 
    handle: '.' + $component + "-item-top",
    animation: 250,
    scroll: true, // or HTMLElement
    scrollSensitivity: 60, // px, how near the mouse must be to an edge to start scrolling.
    scrollSpeed: 10, // px
    ghostClass: "is-dropping",

    onStart: function (event) {
      $('.' + $component).toggleClass('is-dragging');
      console.log('onStart')
    },

    onEnd: function (event) {
      $('.' + $component).toggleClass('is-dragging');
      sort();
    },

  	});

  	var acc = document.getElementsByClassName("accordion");
  	var i;

  	for (i = 0; i < acc.length; i++) {
  	    acc[i].onclick = function(){
  	        this.classList.toggle("active");
  	        this.nextElementSibling.classList.toggle("show");
  	  }
  	}

  	jQuery(document).ready(function($){
  		var contentSections = $('.cd-section'),
  			navigationItems = $('#cd-vertical-nav a');

  		updateNavigation();
  		$(window).on('scroll', function(){
  			updateNavigation();
  		});

  		//smooth scroll to the section
  		navigationItems.on('click', function(event){
  	        event.preventDefault();
  	        smoothScroll($(this.hash));
  	    });
  	    //smooth scroll to second section
  	    $('.cd-scroll-down').on('click', function(event){
  	        event.preventDefault();
  	        smoothScroll($(this.hash));
  	    });

  	    //open-close navigation on touch devices
  	    $('.touch .cd-nav-trigger').on('click', function(){
  	    	$('.touch #cd-vertical-nav').toggleClass('open');
  	  
  	    });
  	    //close navigation on touch devices when selectin an elemnt from the list
  	    $('.touch #cd-vertical-nav a').on('click', function(){
  	    	$('.touch #cd-vertical-nav').removeClass('open');
  	    });

  		function updateNavigation() {
  			contentSections.each(function(){
  				$this = $(this);
  				var activeSection = $('#cd-vertical-nav a[href="#'+$this.attr('id')+'"]').data('number') - 1;
  				if ( ( $this.offset().top - $(window).height()/2 < $(window).scrollTop() ) && ( $this.offset().top + $this.height() - $(window).height()/2 > $(window).scrollTop() ) ) {
  					navigationItems.eq(activeSection).addClass('is-selected');
  				}else {
  					navigationItems.eq(activeSection).removeClass('is-selected');
  				}
  			});
  		}

  		function smoothScroll(target) {
  	        $('body,html').animate(
  	        	{'scrollTop':target.offset().top},
  	        	600
  	        );
  		}
  	});


});

/* for bxslider
$(document).ready(function(){
  $('.bxslider').bxSlider();
});*/
