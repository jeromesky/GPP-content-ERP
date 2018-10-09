


var dataController = (function(){

    var data = {
      locations: {
        list: [],
        get: function(){

        },
        set: function(){

        }
      },
      groups : {
            list : [{id: 0 , name : 'Emails'}, {id: 1 , name : 'FrontEnd'}],
            current : {
              id : 0,
              name : ''
            }
      },

      content: {
            list : [{id: 0, type: 'mail', name: 'the name of my content', updated: '19-02-2017'}],
            item: {}
      }
    };

    var observer = function(){

    };

    return {
      groups : {
        get: function(){
          return data.groups.list;
        },
        set: function(object){
              data.content.list = object;
              console.log('this is the list', data.content.list);
        },
        id: {
          set: function(id){
              data.groups.current.id = id;
          },
          get: function(){
              return data.groups.current.id;
          }
        },
        name: {
          set: function(name){
              data.groups.current.name = name;
          },
          get: function(){
              return data.groups.current.id;
          }
        }
      },
      locations : data.locations,
      // location:{
      //     get : function(){
      //       return ;
      //     },
      //     set: function(array){
      //
      //     }
      // },
      content: {
        list:{
          get: function(){
            return data.content.list;
          },
          set: function(array){
            data.content.list = array;
          }
        }
      },
      report: function(){
        console.log('public', this);
        console.log('private', data);
      }
    };//end return
})();

var ajaxController = (function(){

    var sender = function(dataObj, callback){
        $.ajax({
            url: '?fa='+ dataObj.url,
            method: 'POST',
            data: dataObj,
            processData: true,
            dataType : 'json',
            beforeSend: function(){

            },
            success: function(data, string, xhr){

                  callback(data);
            },
            complete:function(){

            },
            error: function(){

            }
        });
      };

        return {
          send : function(dataObj, successCallback){

              // console.log(dataObj);
              // successCallback();
              $.ajax({
                  url: '?fa='+ dataObj.url,
                  method: 'POST',
                  data: dataObj,
                  processData: true,
                  dataType : 'json'
                  ,beforeSend: function(){
                      console.log('Lets do somethinbg befor sending the data');
                  }
                  ,success: function(data, string, xhr){

                        successCallback(data);
                  }
                  // ,complete:function(){
                  //
                  // }
                  ,error: function( jqXHR , textStatus, exception){
                        note(exception, 'error');
                        console.log(' send error jqXHR: '+ jqXHR);
                        console.log(' send error textStatus: '+ textStatus);
                        console.log(' send error exception: '+ exception);
                  }
              });
          }
        }

})();


var UIController = (function(){

  var insertTableDOM = function(element, object, classN){
            var table = document.getElementById(element);
            var row = table.insertRow(0);
            //  Object.keys(object).forEach(function(currentKey, index) {console.log(key, dictionary[key]); });
            var cell = row.insertCell(0);
           cell.className = classN;
           //set the data-id
           cell.setAttribute("data-id", object.id);
           cell.innerHTML = object.name;
  };

  var loadGroups = function(){
            ajaxCtrl.send({url:  'content.item.get'}, act_loadGroups);
  };

  var act_loadGroups = function(object){
            console.log(object);
  };

  var setFormTitle  = function(element, value){
            document.querySelector('.'+element).innerHTML = value;
  };

  var formLoad = function(obj){
            //go to tab
            $('.nav-tabs a[href="#form"]').tab('show');
            //reset form
            CKEDITOR.instances['contentBody'].updateElement();
            var obj = obj[0];

            console.log(obj);
            //set the form Header title
            setFormTitle ('hd_contentTitle', obj.NAME);
            document.querySelector('input[name="contentID"]').value = obj.CONTENTID;
            document.querySelector('input[name="pageTitle"]').value = obj.PAGETITLE;
            // document.querySelector('.hd_contentTitle').innerHTML = obj.PAGETITLE;
            document.querySelector('input[name="contentName"]').value = obj.NAME;
            document.querySelector('input[name="subject"]').value = obj.CONTENTLABEL;
            document.querySelector('textarea[name="description"]').value = obj.CONTENTTEXT;
            //
            CKEDITOR.instances['contentBody'].setData(obj.HTML);

            var typeGroup = document.getElementsByName('contentType');
            typeGroup.forEach(function(item, index){

                (typeGroup[index].value === obj.CONTENTTYPE)
                  ? typeGroup[index].checked = true
                  : '';
            });
  };


  var locations_draw = function(object){
          var table = document.getElementById('location_list');
          var row = table.insertRow(0);
          row.onclick = controller.locations.click;
          row.id = "location_" + object.GROUPID;
           var cellName = row.insertCell(0);
           cellName.innerHTML = object.GROUPNAME;
           cellName.className = "click_location pointer";
           cellName.setAttribute("data-id", object.GROUPID);
  };


  return {
    portlet: {
      header : {
        draw : setFormTitle
      }
    },
    list  : {
      clear: function(el){
              var tbody = document.getElementById(el);
              //or use :  var table = document.all.tableid;
              for(var i = tbody.rows.length - 1; i >= 0; i--)
              {
                  tbody.deleteRow(i);
              }
      }
    },
    locations : {
      draw : locations_draw
    },
    group : {
      new : {
        clear: function(){

        },
        get : function(){
          return  document.querySelector('#addGroup').value;
        }
      },
      draw : function(object){
              var table = document.getElementById('group_list');
              var row = table.insertRow(0);
              row.id = "content_" + object.contentid;
               var cellName = row.insertCell(0);
               var cellType = row.insertCell(1);
               var cellDate = row.insertCell(2);
               cellName.innerHTML = object.name;
               cellType.innerHTML = object.type;
               cellDate.innerHTML = object.staffupddatedname + ' <small>' + dateFormat(object.dateupdated) +'</small>';
               cellName.className = "formLoad pointer";
               cellType.className = "formLoad pointer";
               cellDate.className = "formLoad pointer";
               cellName.setAttribute("data-id", object.contentid);
               cellType.setAttribute("data-id", object.contentid);
               cellDate.setAttribute("data-id", object.contentid);
      }
    },
    form : {
      load : formLoad
    }
  }//end return

})();





var controller = (function(UICtrl, dataCtrl, ajaxCtrl){
    var initEventListeners, loadGroupList, get_formData;
    var formSubmit, formSuccess;

    initEventListeners = function(){

          document.querySelector('#btn_addLocation').addEventListener('click', ctrlAddLocation);


          // dynListener(document, "click", ".click_location", ctrlListClick, location_list);

          ///this is for Dynamic loaded elements
          dynListener(document, "click", ".formLoad", ctrlListClick);
          //content form
          document.getElementById('formContent').addEventListener("submit", formSubmit);

          //listin for change on the content name
          document.querySelector('input[name="contentName"]').addEventListener('keyup', function(event){
              UIController.portlet.header.draw('hd_contentTitle', event.target.value)
          });

          //load the locations group list
          locations_get();
    };

    get_formData = function(){

          var form = {
              contentTypeID: dataCtrl.groups.id.get(),
              contentType : document.querySelector('input[name="contentType"]:checked').value,
              contentID   : document.querySelector('input[name="contentID"]').value,
              title       : document.querySelector('input[name="pageTitle"]').value,
              name        : document.querySelector('input[name="contentName"]').value,
              subject     : document.querySelector('input[name="subject"]').value,
              description : document.querySelector('textarea[name="description"]').value,
              contentBody : CKEDITOR.instances['contentBody'].getData(),
              error       : {
                  message   : 'minimum fields present',
                  status    : 0
              }
          };
          console.log('form.title.length', form.title.length);
          console.log('form.name.length', form.name.length);
          console.log('form.contentBody.length', form.contentBody.length);
          if(!form.title.length || !form.name.length || !form.contentBody.length){

            form.error.message = 'Minimum fields required for submiting form error';
            form.error.status = 1;
          }


          return form;
    };

    formSubmit = function(event){
          event.preventDefault();

          var paramObj = get_formData();

          if(paramObj.error.status){
            note(paramObj.error.message, 'error');
            return false;
          }
          paramObj.url = 'content.item.add';
          ajaxCtrl.send(paramObj, formSuccess);
    };

    formSuccess = function(){

        console.log('Form has been submited and here is the groupID: ', dataController.groups.id.get());


        UIController.form.load([{ NAME : '',HTML : '',CONTENTID: 0,PAGETITLE: '',CONTENTLABEL: '',CONTENTTEXT : '', CONTENTTYPE : 'mail'}]);
        note('Content successfully Saved!!', 'success');
        list_get();
        // $('.nav-tabs').children('li').removeClass('active');
        // $('.tab-content').children('div').removeClass('active');
        $('.nav-tabs a[href="#select"]').tab('show');
    };

    var ctrlListClick = function(event){

        //no group yet selected refuse action
        if(!dataController.groups.id.get()){

          // alert('Please select a Group to continue');
          note('Please select a Group to continue', 'error');
          return false;
        }

        var ajaxObj = {
          contentID : event.target.getAttribute('data-id'),
          name: 0,
          // contentTypeID: dataController.groups.id.get(),
          url:  'content.item.get'
        };
        //set current item
        // console.log(ajaxObj);
        ajaxCtrl.send(ajaxObj, actLinkClick);
    };

    var actLinkClick = function(data){

      // console.log('data back from server= ', data);
      UICtrl.form.load(data)
    };

    var ctrlLocationClick = function(event){
          console.log(this);
          console.log(event);
          var groupID = event.target.getAttribute('data-id');
          var groupName = event.target.innerHTML;

          //set vars
          dataCtrl.groups.id.set(groupID);
          dataCtrl.groups.name.set(groupName);
          //
          list_get();
          //print data
          // dataCtrl.report();
          UICtrl.portlet.header.draw('hd_groupList', groupName);
    };

    var actGroupClick = function(data){


    };

    var list_get = function(){
          var ajaxObj = {
            groupID : dataCtrl.groups.id.get(),
            url : 'content.groups.list'
          };

          ajaxCtrl.send(ajaxObj, List_build);
    }
    var List_build = function(data){
          // //clear the list
          UIController.list.clear('group_list');
          //will need to add check to see if we have data to use
          //set new array to fill, array keys may be in Capital letters
          var newArr = [];
          for(index in data){
            newArr.push(keyToLowerCase(data[index]));
          }
          //set the list array of the selected group in the ;
          dataCtrl.content.list.set(newArr);

          //send objects to draw list
          for(index in newArr){
            UICtrl.group.draw(newArr[index]);
          }
    };

    var ctrlAddLocation = function(event){
          event.preventDefault();
          var input = UICtrl.group.new.get();
          //clear the field
          UICtrl.group.new.clear();
          ajaxCtrl.send({url: 'content.group.put', value: input}, actAddLocation);
          console.log('Group input value to add ', input);
    };

    var actAddLocation = function(object){

          // window.location  .reload(true);
          var obj = jQuery.parseJSON(object);
          dataCtrl.locations.list.push(obj);
          console.log('reload page sldksldklskdlskdlk');
    }

    var locations_get = function(){
          console.log('inside locations_get ');
          ajaxCtrl.send({url : 'content.locations.list', value: 'sdsddsd'}, location_build);
    };

    var location_build = function(array){
          console.log('inside location builder');
          console.log(array);
          dataCtrl.locations.list = array;
          for(var index in array ){
              // console.log(array[index].GROUPNAME);
              UICtrl.locations.draw(array[index]);
          }
          // UIController.list.clear('location_list');
          // var newArr = [];
          // for(index in data){
          //   newArr.push(keyToLowerCase(data[index]));
          // }
          // //set the list array of the selected group in the ;
          // // dataCtrl.content.list.set(newArr);
          //
          // //send objects to draw list
          // for(index in newArr){
          //   UICtrl.location.draw(newArr[index]);
          // }
    };


    var get_groups = function(){


    };


  return {
    init: function(){

      initEventListeners();
      console.log('App has loaded,');
    },
    form : {
      submit : formSubmit
    },
    locations: {
      click : ctrlLocationClick
    },
    test : function(){
      return this;
    }
  }

})(UIController, dataController, ajaxController);



  controller.init();
  // FormValidation.init();


var keyToLowerCase = function(obj){
      		var newObject = {};
          Object.keys(obj).forEach(function(key, index) {
          		newObject[key.toLowerCase()] = obj[key];
          });
      return newObject;
};


function dynListener(el, evt, sel, handler) {
    el.addEventListener(evt, function(event) {
        var t = event.target;
        while (t && t !== this) {
            if (t.matches(sel)) {
                handler.call(t, event);
            }
            t = t.parentNode;
        }
    });
}

function dateFormat(date){
  var ft = new Date(date);
  var year = ft.getFullYear();
  var month = ft.getMonth(); // months are zero indexed
  var day = ft.getDate();
  var monthNames = ["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"];
    return day + ' ' + monthNames[month] + ' ' + year ;
    // return day + ' ' + month  + ' ' + year;
}

var note = function(message, type){
  var messageType = {
      error   : 'note-danger',
      warning : 'note-warning',
      info    : 'note-info',
      success : 'note-success'
  };

  el = document.querySelector('.note');
  el.classList.remove("hidden");
  el.classList.add(messageType[type]);
  el.innerHTML = message;
  console.log('Show message in Note tag');

  setTimeout(function(){
    el.classList.add('hidden');
  }, 4000);

};


// swal({
//   title: "Ooooh snap, An Error",
//   text: "Something happened",
//   type: "warning",
//   showCancelButton: false,
//   confirmButtonClass: "btn-danger",
//   confirmButtonText: "OK",
//   closeOnConfirm: false
//   },
//   function(){
//     swal("Got it!", "Lets try this again, close and go ahead.", "success");
//   }
// );

// Object.prototype.keyToLowerCase = function(obj){
//
//           console.log('objectdddd', obj);
//       		var newObject = {};
//           Object.keys(obj).forEach(function(key, index) {
//           		newObject[key.toLowerCase()] = obj[key];
//           });
//
//       return newObject;
// };

  // Array.prototype.keyToLowerCase = function(array){
  //       var newArr = [];
  //       for(arrIndex in  array){
  //       		var newObject = {};
  //           Object.keys(array[arrIndex]).forEach(function(key, index) {
  //           		newObject[key.toLowerCase()] = array[arrIndex][key];
  //           });
  //           newArr.push(newObject);
  //       }
  //       return newArr;
  // };
