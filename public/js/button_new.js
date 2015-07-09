function add_command() {
    $("#commands").append(
        "<div class='well well-sm col-sm-offset-2 col-sm-7' id='command'>" +
         "<div class='form-group'> "+
           "<label for='addon' class='col-sm-3 control-label'>Addon</label>" +
           "<div class='col-sm-9'>" +
             "<input type='text' class='form-control' id='addon'>" +
           "</div>" +
         "</div>" +
         "<div class='form-group'>" +
           "<label for='sleep' class='col-sm-3 control-label'>Sleep</label>" +
           "<div class='col-sm-9'>" +
             "<input type='number' class='form-control' id='sleep'>" +
           "</div>" +
         "</div>" +
         "<div class='form-group'>" +
           "<label for='para' class='col-sm-3 control-label'>Parameter</label>" +
           "<div class='col-sm-4 parameter-field left'> "+
             "<input type='text' class='form-control' id='key'>" +
           "</div>" +
           "<div class='col-sm-4 parameter-field right'> "+
             "<input type='text' class='form-control' id='value'>" +
           "</div>" +
           "<button type='button' class='btn btn-sx btn-success parameter-btn' onclick='add_parameter(this)'><span class='glyphicon glyphicon-plus'></span></button>" +
         "</div>" +
        "</div>"
        );
}

function add_parameter(element){
    $(element).parent().append(
           "<label for='para' class='col-sm-3 control-label'></label>" +
           "<div class='col-sm-4 parameter-field left'> "+
             "<input type='text' class='form-control' id='key'>" +
           "</div>" +
           "<div class='col-sm-4 parameter-field right'> "+
             "<input type='text' class='form-control' id='value'>" +
           "</div>"
        );
}

function save(){
    var button = {
        label: $("label").val(),
        icon: $("icon").val(),
        show: $("show").val(),
        device: $("device").val(),
        action: $("action").val(),
        commmands: []
    }
    var commands_dom = $("#commands").children("#command");
    for(var i=0; i<commands_dom.length; i++){
        console.log(commands_dom[i]);
        // var command = {
        //     addon: commands_dom[i].children("#addon").val(),
        //     sleep: commands_dom[i].children("#sleep").val(),
        // }
        // button.commmands.push(command);
    }
    console.log(button);
}
