$(function() {
	validateLoginUsuarioBS4();
})

function fncSweetAlert(type, text, url){

	switch (type) {

		/*=============================================
		Cuando ocurre un error
		=============================================*/

		case "error":

		if(url == null){

		  	Swal.fire({
	            icon: 'error',
	            title: 'Error',
	            text: text
	        }) 

	    }else{

	    	Swal.fire({
	            icon: 'error',
	            title: 'Error',
	            text: text
	        }).then((result) => {

    	 		if (result.value) { 

    	 			window.open(url, "_top");

    	 		}

	        }) 

	    }

        break;

        /*=============================================
		Cuando es correcto
		=============================================*/

		case "success":

		if(url == null){

		  	Swal.fire({
	            icon: 'success',
	            title: 'Success',
	            text: text,
				allowOutsideClick: false,
    			allowEscapeKey: false
	        }) 

	    }else{

	    	Swal.fire({
	            icon: 'success',
	            title: 'Confirmación',
	            text: text,
				allowOutsideClick: false,
    			allowEscapeKey: false
	        }).then((result) => {

    	 		if (result.value) { 

    	 			window.open(url, "_top");

    	 		}

	        }) 

	    }

        break;

        /*=============================================
		Cuando estamos precargando
		=============================================*/

		case "loading":

		  Swal.fire({
            allowOutsideClick: false,
            icon: 'info',
            text:text
          })
          Swal.showLoading()

        break;  

        /*=============================================
		Cuando necesitamos cerrar la alerta suave
		=============================================*/

		case "close":

		 	Swal.close()
		 	
		break;



	}

}

function validateLoginUsuarioBS4(){

	(function() {
	  'use strict';
	  window.addEventListener('load', function() {
		// Get the forms we want to add validation styles to
		var forms = document.getElementsByClassName('needs-validation-login');
		// Loop over them and prevent submission
		var validation = Array.prototype.filter.call(forms, function(form) {
		  form.addEventListener('submit', function(event) {
			if (form.checkValidity() === false) {
			  event.preventDefault();
			  event.stopPropagation();
			}
			form.classList.add('was-validated');
									 
		  }, false);
		});
	  }, false);
	})();

}

function mensajeToast(tipo_mensaje = 'error',mensaje){
	
	toastr.options.progressBar = true;
	toastr.options.timeOut = 3000; // How long the toast will display without user interaction
	toastr.options.extendedTimeOut = 3000; 
	toastr.options.positionClass = 'toast-top-right';

	if(tipo_mensaje == 'error'){
		toastr.error(mensaje);
	}

	if(tipo_mensaje == 'success'){
		toastr.success(mensaje);
	}

	if(tipo_mensaje == 'warning'){
		toastr.warning(mensaje);
	}

	if(tipo_mensaje == 'info'){
		toastr.info(mensaje);
	}
	
	

}

function ajustarHeadersDataTables(element) {

	var observer = window.ResizeObserver ? new ResizeObserver(function(entries) {
		entries.forEach(function(entry) {
			$(entry.target).DataTable().columns.adjust();
		});
	}) : null;

	// Function to add a datatable to the ResizeObserver entries array
	resizeHandler = function($table) {
		if (observer)
			observer.observe($table[0]);
	};

	// Initiate additional resize handling on datatable
	resizeHandler(element);

}