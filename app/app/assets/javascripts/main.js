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

		$this.on('click', function(event) {
			event.preventDefault();
			$(window).scrollTo(target, 400);
		});

	$(".dropdown-toggle").dropdown();
    $(window).scroll(function(){
        if ($(this).scrollTop()>0){
        	$('.banner-notice').fadeOut();
        	$('.page-header').css('top', '1rem');
			$projectNavigation.css('top', '0').sticky({
				topSpacing: 0
			});
     	}
    });

	// Waypoints
		var waypoint = new Waypoint({
			element: document.getElementById(target.substring(1)),
			offset: 67,
			handler: function(direction) {
				var _filter = '[href=' + target + ']';

				$siteMenu.removeClass('enabled');
				$pageButton.removeClass('enabled');
				$main.removeClass('enabled');

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
	$('.banner-notice .js-close').on('click', function() {
		$(this).parents('.banner-notice').hide();
		$('.page-header').css('top', '1rem');
		$projectNavigation.css('top', '0').sticky({
			topSpacing: 0
		});
	});

	$('#admin-project-proposal-table').dataTable( {
        responsive: {
            details: {
                type: 'column'
            }
        },
        columnDefs: [ {
            className: 'control',
            orderable: false,
            targets:   0
        } ],
        order: [ 1, 'asc' ]
    } );

    $(".dropdown-toggle").dropdown();
    $(window).scroll(function(){
        if ($(this).scrollTop()>0){
        	$('#banner').fadeOut();
     	}else{
      		$('#banner').fadeIn();
     	}
    });

});


/* for bxslider
$(document).ready(function(){
  $('.bxslider').bxSlider();
});*/

