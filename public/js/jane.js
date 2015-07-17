function run(device_in, action_in){
    $.get("v1", { device : device_in, action : action_in});
}

function create_job(){
    var job = {
        device: $("#device").val(),
        action: $("#action").val(),
        hour: $("#hour").val(),
        min: $("#min").val(),
        sec: $("#sec").val(),
    }
    $.get("job/create", job, update_schedule);
}

function cancel_job(id){
    job_id = {id: id}
    $.get("job/cancel", job_id, update_schedule);
}

function job_list(){
    $.get("job/list", update_schedule);
}

function get_devices(){
    $.get("devices", update_devices);
}

function update_schedule(data){
    // transform json to li elements
    $("#job-list").html(function(){
        var new_list = "";
        for(var i = 0; i < data.length; i++){
            new_list += "<li class=\"list-group-item clearfix\"" + "job_id=" + data[i]["id"]+">" +
             "<span class=\"pull-right\">" +
                "<button class=\"btn btn-sm btn-danger btn-circle\"" + 
                         "onclick=\"cancel_job(" + data[i]["id"] + ")\">" +
                    "<span class=\"glyphicon glyphicon-remove\"></span>" + 
                "</button>" +
             "</span>" +
             "<span class=\"glyphicon glyphicon-time job-icon\"></span>" + data[i]["end_time"] +
             "</br>" +
             "<span class=\"glyphicon glyphicon-phone job-icon\"></span>" + data[i]["device"] +
             "</br>" +
             "<span class=\"glyphicon glyphicon-random job-icon\"></span>" + data[i]["action"] +
             "</li>";
        }
        return new_list;
    });
}

function update_devices(data){
    $("#device").html(function(){
        var options = "";
        var devices = [];
        for(var device in data){
            if(data.hasOwnProperty(device)){
                devices.push(device);
            }
        }
        for(var i=0; i<devices.length; i++){
            options += "<option value=" + devices[i] + ">" + devices[i] + "</option>\n";
        }
        return options;
    });
    var device = {device :$("#device").first().val()}
    $.get("actions", device, update_actions);
}

function update_actions(data){
    $("#action").html(function(){
        var actions = [];
        var options = "";
        for(var i=0; i<data.length; i++){
            options += "<option value=" + data[i] + ">" + data[i] + "</option>\n";
        }
        return options;
    });
}

$( document ).ready(function(){
    job_list();
    get_devices();

    $("#device").change(function(){
        var device = {device: $(this).val()}
        $.get("actions", device, update_actions);
    });
});
