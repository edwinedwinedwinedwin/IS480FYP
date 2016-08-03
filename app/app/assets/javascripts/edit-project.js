$(function() {
	// PROJECT EDIT INTERFACE
	var currentElement;
	var $editButtons = $('.js-edit-button');

	$editButtons.each(function() {
		var $this = $(this),
			container = $this.attr('data-container');

		container = $('#' + container);

		$this.on('click', function() {
			$editButtons.removeClass('enabled');
		});

		container.on('mouseenter', function() {
			if(!currentElement) {
				$this.addClass('enabled');
			}
		});

		container.on('mouseleave', function() {
			$this.removeClass('enabled');
		});
	});



	// Project title
	var projectTitle = {};
	projectTitle.el = $('#project-title');
	projectTitle = {
		el: projectTitle.el,
		editButton: $('#project-title-edit'),
		saveButton: $('#project-title-save'),
		overlay: $('#project-hero-overlay'),
		isEditing: false,
		initialText: projectTitle.el.text(),
		editOn: function() {
			if(!currentElement) {
				currentElement = projectTitle;

				// Save initial text value
				projectTitle.initialText = projectTitle.el.text();

				// Set contenteditable
				projectTitle.el
							.attr('contenteditable', 'true')
							.addClass('edit-on');

				projectTitle.overlay
							.addClass('enabled');

				projectTitle.saveButton
							.addClass('enabled');

				$editButtons.addClass('hidden');

				projectTitle.isEditing = true;
			}
		},
		editOff: function(saveChanges) {
			projectTitle.el
						.removeAttr('contenteditable')
						.removeClass('edit-on')
						.blur();

			if(!saveChanges) {
				projectTitle.el.text(projectTitle.initialText);
			}

			projectTitle.overlay.removeClass('enabled');
			projectTitle.saveButton.removeClass('enabled');

			$editButtons.removeClass('hidden');

			projectTitle.isEditing = false;
			currentElement = false;
		},
		editToggle: function(saveChanges) {
			if(projectTitle.isEditing) {
				projectTitle.editOff(saveChanges);
			}

			else {
				projectTitle.editOn();
			}
		}
	};





	// Project category
	var projectCategory = {};
	projectCategory.el = $('#project-category__text');
	projectCategory = {
		el: projectCategory.el,
		editButton: $('#project-category-edit'),
		saveButton: $('#project-category-save'),
		overlay: $('#project-hero-overlay'),
		isEditing: false,
		initialText: projectCategory.el.text(),
		editOn: function() {
			if(!currentElement) {
				currentElement = projectCategory;

				// Save initial text value
				projectCategory.initialText = projectCategory.el.text();

				$('#project-category-selector').show();

				projectCategory.overlay
							.addClass('enabled');

				projectCategory.saveButton
							.addClass('enabled');

				$editButtons.addClass('hidden');

				projectCategory.isEditing = true;
			}
		},
		editOff: function(saveChanges) {
			projectCategory.el
						.removeAttr('contenteditable')
						.removeClass('edit-on')
						.blur();

			if(!saveChanges) {
				projectCategory.el.text(projectCategory.initialText);
			}

			else {
				var text = $('#project-category-list .selected').text();
				projectCategory.el.text(text);
			}

			projectCategory.overlay.removeClass('enabled');
			projectCategory.saveButton.removeClass('enabled');
			$('#project-category-selector').hide();

			$editButtons.removeClass('hidden');

			projectCategory.isEditing = false;
			currentElement = false;
		},
		editToggle: function(saveChanges) {
			if(projectCategory.isEditing) {
				projectCategory.editOff(saveChanges);
			}

			else {
				projectCategory.editOn();
			}
		}
	};





	// Project Description
	var projectDescription = {};
	projectDescription.el = $('#project-description');
	projectDescription = {
		el: projectDescription.el,
		editButton: $('#project-description-edit'),
		saveButton: $('#project-description-save'),
		isEditing: false,
		initialText: projectDescription.el.html(),
		editOn: function() {
			if(!currentElement) {
				currentElement = projectDescription;

				// Save initial text value
				projectDescription.initialText = projectDescription.el.html();

				// Set contenteditable
				projectDescription.el
					.attr('contenteditable', 'true')
					.addClass('edit-on');

				projectDescription.saveButton
					.addClass('enabled');

				$editButtons.addClass('hidden');

				projectDescription.isEditing = true;
			}
		},
		editOff: function(saveChanges) {
			projectDescription.el
				.removeAttr('contenteditable')
				.removeClass('edit-on')
				.blur();

			if(!saveChanges) {
				projectDescription.el.html(projectDescription.initialText);
			}

			projectDescription.saveButton.removeClass('enabled');

			$editButtons.removeClass('hidden');

			projectDescription.isEditing = false;
			currentElement = false;
		},
		editToggle: function(saveChanges) {
			if(projectDescription.isEditing) {
				projectDescription.editOff(saveChanges);
			}

			else {
				projectDescription.editOn();
			}
		}
	};




	// Project FundingGoal
	var projectFundingGoal = {};
	projectFundingGoal.el = $('#project-funding-goal');
	projectFundingGoal = {
		el: projectFundingGoal.el,
		editButton: $('#project-funding-goal-edit'),
		saveButton: $('#project-funding-goal-save'),
		overlay: $('#project-funding-goal-overlay'),
		isEditing: false,
		initialText: projectFundingGoal.el.html(),
		editOn: function() {
			if(!currentElement) {
				currentElement = projectFundingGoal;

				// Enable overlay
				projectFundingGoal.overlay.addClass('enabled');

				// Save initial text value
				projectFundingGoal.initialText = projectFundingGoal.el.html();

				// Set contenteditable
				projectFundingGoal.el
					.parents('.project-funding-goal')
					.addClass('enabled');

				projectFundingGoal.saveButton
					.addClass('enabled');

				$editButtons.addClass('hidden');

				projectFundingGoal.isEditing = true;
			}
		},
		editOff: function(saveChanges) {
			projectFundingGoal.el
				.parents('.project-funding-goal')
				.removeClass('enabled');

			projectFundingGoal.overlay.removeClass('enabled');

			if(!saveChanges) {
				projectFundingGoal.el.html(projectFundingGoal.initialText);
			}

			if(saveChanges) {
				$('#project-funding-value').text(projectFundingGoal.el.text());
			}

			projectFundingGoal.saveButton.removeClass('enabled');

			$editButtons.removeClass('hidden');

			projectFundingGoal.isEditing = false;
			currentElement = false;
		},
		editToggle: function(saveChanges) {
			if(projectFundingGoal.isEditing) {
				projectFundingGoal.editOff(saveChanges);
			}

			else {
				projectFundingGoal.editOn();
			}
		}
	};




	// Project gallery management
	var projectGalleryManagement = {};
	projectGalleryManagement.el = $('#project-gallery-management');
	projectGalleryManagement = {
		el: projectGalleryManagement.el,
		editButton: $('#project-images-edit'),
		saveButton: $('#project-gallery-management-save'),
		overlay: $('#project-gallery-overlay'),
		isEditing: false,
		editOn: function() {
			if(!currentElement) {
				currentElement = projectGalleryManagement;

				// Enable overlay
				projectGalleryManagement.overlay.addClass('enabled');

				// Set contenteditable
				projectGalleryManagement.el
					.addClass('enabled');

				projectGalleryManagement.saveButton
					.addClass('enabled');

				$editButtons.addClass('hidden');

				projectGalleryManagement.isEditing = true;
			}
		},
		editOff: function(saveChanges) {
			projectGalleryManagement.el
				.removeClass('enabled');

			projectGalleryManagement.overlay.removeClass('enabled');

			projectGalleryManagement.saveButton.removeClass('enabled');

			$editButtons.removeClass('hidden');

			projectGalleryManagement.isEditing = false;
			currentElement = false;
		},
		editToggle: function(saveChanges) {
			if(projectGalleryManagement.isEditing) {
				projectGalleryManagement.editOff(saveChanges);
			}

			else {
				projectGalleryManagement.editOn();
			}
		}
	};




	// Project inspiration management
	var projectInspirationManagement = {};
	projectInspirationManagement.el = $('#project-inspiration-management');
	projectInspirationManagement = {
		el: projectInspirationManagement.el,
		editButton: $('#project-inspiration-edit'),
		saveButton: $('#project-inspiration-save'),
		overlay: $(),
		isEditing: false,
		editOn: function() {
			if(!currentElement) {
				currentElement = projectInspirationManagement;

				// Hide inspiration frontend
				$('#project-inspiration-view').hide();

				// Show edit interface
				projectInspirationManagement.el.show();
				$('.js-inspiration-step').first().show();

				$editButtons.addClass('hidden');

				projectInspirationManagement.isEditing = true;
			}
		},
		editOff: function(saveChanges) {
			projectInspirationManagement.el
				.removeClass('enabled');

			$editButtons.removeClass('hidden');

			projectInspirationManagement.isEditing = false;
			currentElement = false;
		},
		editToggle: function(saveChanges) {
			if(projectInspirationManagement.isEditing) {
				projectInspirationManagement.editOff(saveChanges);
			}

			else {
				projectInspirationManagement.editOn();
			}
		}
	};




	// Project team management
	var projectTeamManagement = {};
	projectTeamManagement.el = $('#project-team-management');
	projectTeamManagement = {
		el: projectTeamManagement.el,
		editButton: $('#project-team-edit'),
		saveButton: $('#project-team-save'),
		overlay: $(),
		isEditing: false,
		editOn: function() {
			if(!currentElement) {
				currentElement = projectTeamManagement;

				// Hide inspiration frontend
				$('#project-team-members').hide();

				// Show edit interface
				$('#project-team-heading').addClass('enabled');
				projectTeamManagement.el.show();
				projectTeamManagement.saveButton.addClass('enabled');

				$editButtons.addClass('hidden');

				projectTeamManagement.isEditing = true;
			}
		},
		editOff: function(saveChanges) {
			projectTeamManagement.el.hide();
			projectTeamManagement.saveButton.removeClass('enabled');

			$('#project-team-heading').removeClass('enabled');

			$editButtons.removeClass('hidden');

			$('#project-team-members').show();

			projectTeamManagement.isEditing = false;
			currentElement = false;
		},
		editToggle: function(saveChanges) {
			if(projectTeamManagement.isEditing) {
				projectTeamManagement.editOff(saveChanges);
			}

			else {
				projectTeamManagement.editOn();
			}
		}
	};





	var elements = [projectTitle, projectCategory, projectDescription, projectFundingGoal, projectGalleryManagement, projectInspirationManagement, projectTeamManagement];

	// Loop through elements array and execute code for each element
	for(var i = 0; i < elements.length; i++) {
		var element = elements[i];

		element.editButton.on('click', element.editOn);
		element.saveButton.on('click', element.editOff);

		if(element.overlay) {
			element.overlay.on('click', element.editOff);
		}
	}

	$('#project-title').on('click', function() {
		if(!currentElement) {
			projectTitle.editOn();
		}
	});

	$('#project-funding').on('click', function() {
		if(!currentElement) {
			projectFundingGoal.editOn();
		}
	});



	// Project Inspiration interface
	var inspirationProgress = $('#inspiration-progress');

	$('.js-inspiration-step').hide();
	$('.js-inspiration-next').on('click', function() {
		var $this = $(this),
			currentStep = $this.parents('.js-inspiration-step'),
			nextStep = currentStep.next();

		currentStep.hide();

		if(nextStep.length > 0) {
			nextStep.show();
		}

		else {
			$('#project-inspiration-view').show();
			$('#project-inspiration-management').hide();
		}

		var currentProgressStep = inspirationProgress.find('.current'),
			nextProgressStep = currentProgressStep.next();

			if(nextProgressStep.length > 0) {
				currentProgressStep.removeClass('current');
				nextProgressStep.addClass('current');
			}

			else {
				currentProgressStep.removeClass('current');
				inspirationProgress.find('.progress-step').first().addClass('current');
			}
	});

	// Progress step navigation
	$('#inspiration-progress').find('.progress-step').on('click', function() {
		var index = $(this).index();
		inspirationProgress.find('.current').removeClass('current');
		$(this).addClass('current');
		projectInspirationManagement.el.find('.js-inspiration-step').hide();
		projectInspirationManagement.el.find('.js-inspiration-step').eq(index).show();
	});




	// Discard changes and exit editing interface on Escape key press
	$(document).keyup(function(e) {
		if (e.keyCode == 27) { // Escape
			if(currentElement && currentElement.editOff) {
				currentElement.editOff(false);
			}
		}
	});

	// Project category selector
	var projectCategorySelector = $('#project-category-selector'),
		projectCategoryItems = projectCategorySelector.find('li');
	projectCategoryItems.on('click', function() {
			projectCategoryItems.removeClass('selected');
			$(this).addClass('selected');
	});


	// Drag-able gallery thumbnails
	var galleryThumbnails = document.getElementById('gallery-thumbnails');
	var sortable = new Sortable(galleryThumbnails, {
		animation: 200,
		handle: '.js-reorder',
		filter: '.js-ignore',
		draggable: '.js-draggable'
	});

	$('.js-delete').on('click', function() {
		var $this = $(this),
			el = $this.parents('.js-delete-container');

		el.fadeOut(200, function() {
			$(this).remove();
		});
	});

	// Drag-able accordion items
	var accordionItems = document.getElementById('accordion-list');
	var accordionSort = new Sortable(accordionItems, {
		animation: 200,
		handle: '.js-reorder-handle',
		draggable: '.js-draggable'
	});

	// Accordion list
	$('.accordion-list').on('click', '.accordion-item-preview', function() {
		$('.accordion-item-content').hide();
		$('.accordion-item-preview').show();
		$(this).hide().siblings('.accordion-item-content').show();
	});

	$('.accordion-list').on('click', '.js-accordion-close', function() {
		$(this).parents('.accordion-item').find('.accordion-item-content').hide().siblings('.accordion-item-preview').show();
	})

	$('.accordion-add').on('click', function() {
		var accordionList = $(this).siblings('.accordion-list');
		var newItem = accordionList.find('.accordion-item').eq(0).clone().appendTo(accordionList);
		newItem.find('.accordion-item-number').text(newItem.index() + 1);
		newItem.find('.accordion-item-preview img').remove();
		newItem.find('.accordion-item-content img').attr('src', 'img/accordion-add.png');
		newItem.find('.accordion-item-content textarea').val('');
		newItem.find('.accordion-item-preview__content').text('...');

		newItem.find('.accordion-item-preview').hide();
		newItem.find('.accordion-item-content').show();
	});


	// Invite List
	$('.js-invite-list-delete').on('click', function() {
		$(this).parents('.invite-list-item').find('input').val('');
	});

	// Invite Send
	$('.js-invite-send').on('click', function() {
		$('#team-invite-textarea').val('Your invites have been sent successfully!');
	})
});