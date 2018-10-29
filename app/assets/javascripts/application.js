// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require slick.min
//= require navigation-toggle
//= require_tree .

$(document).ready(function(){
    $('#search_input').keyup(function(){
    	$("#result_search").empty();
    	var q = $(this).val();
	    if(q.length > 0){
	    	$("#result_search").append("<li class='search-item'><i class='fa fa-spinner fa-pulse'></i><span class='sr-only'>Pesquisando...</span></li>");
	    	$.ajax({
		        type: "GET",
		        url: "/search",
		        dataType: "json",
		        data: {'q': q},
		        success: function(result){
		        	$("#result_search").empty();
		            render = true;
		            $("#result_search").on("click", "li.search-item", function(){
		                $("#result_search").remove();
		                if($(this).data('id')){
		                	window.location.href = "/"+$(this).data('group')+"/"+$(this).data('id');
		                }
		            });
		            group = "";
		            count = 0;
		            for(term in result){
		            	count++;
		                render = false;
		                if(result[term].group!=group){
		                	$("#result_search").append("<li class='search-group'><span>" + result[term].group.toUpperCase() + "</span></li>");
		                	group = result[term].group;
		                }
		                $("#result_search").append("<li class='search-item' data-group="+result[term].group.toLowerCase()+" data-id="+result[term].slug+">" + result[term].nome + "</li>");
		            }
		            if(count ==0){
		            	$("#result_search").append("<li class='search-item'><span>Não foram encontrados dados para a pesquisa</span></li>");
		            }
		        },
		        error: function(XMLHttpRequest, textStatus, errorThrown) {
			    	$("#result_search").append("<li class='search-item'><span>Não foram encontrados dados para a pesquisa</span></li>");
	    		}
	    	});
	    }
	});

	$('.search_prod_name').keyup(function(){
    	$(".prodCheck").empty();
    	var q = $(this).val();
	    if(q.length >= 3){
	    	$(".prodCheck").append("<i class='fa fa-spinner fa-pulse'></i><span class='sr-only'>Pesquisando...</span>");
	    	$.ajax({
		        type: "GET",
		        url: "/produto/checkprod",
		        dataType: "json",
		        data: {'q': q},
		        success: function(result){
		        	$(".prodCheck").empty();
		            if(!result.existe){
		            	$(".prodCheck").append("<h5 style='color:green'><i class='fa fa-thumbs-o-up'></i> Nome disponível</h5>")
		            }
		            else{
		            	$(".prodCheck").append("<h5 style='color:red' class='fa fa-thumbs-o-down'></i> Nome indisponível</h5>")
		            }
	            },
		        error: function(XMLHttpRequest, textStatus, errorThrown) {
		        	$(".prodCheck").html("<span>Falha na verificação do nome do produto informado</span>");
	    		}
	    	});
	    }
	});

	// Carrossel da Home
  $('.js-carousel-blockquote').slick({
  	arrows: false
  });
});
