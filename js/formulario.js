function mostrarForm() {        
    var radioValue = $("input[name='producto']:checked").val();
    sessionStorage.setItem("producto", radioValue); 
    $('#ContentPlaceHolder1_hiddenArticulo').val(radioValue);
    $('#ContentPlaceHolder1_btnArticulo').click();
    //$('#form1').trigger("reset");
}

window.onload = function () {    
    if (sessionStorage.getItem("producto") != "articulo") {
        $("input[name='producto'][value='" + sessionStorage.getItem("producto")+"']").attr('checked', 'checked');
    }    
}