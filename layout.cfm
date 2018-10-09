<!-- BEGIN CONTENT -->
                <div class="page-content-wrapper" id="contents">
                    <!-- BEGIN CONTENT BODY -->
                    <div class="page-content">
                        <!-- BEGIN PAGE HEADER-->


                        <!-- BEGIN PAGE TITLE-->
                        <h1 class="page-title">Content
                            <small>Public WebSite and Email Contents</small>
                        </h1>
                        <!-- END PAGE TITLE-->
                        <!-- END PAGE HEADER-->
                        <div class="hidden note note-info">
                            <p> Here we can messag eto display after acvtions </p>
                        </div>


                        <!--- start body row --->
                        <div class="row">

                          <div class="col-md-12">

                            <!-- Navigation Tabs -->
                            <ul class="nav nav-tabs">
                              <li class="active"><a href="#select" data-toggle="tab"> Select </a></li>
                              <li><a href="#form" data-toggle="tab"> Form </a></li>
                            </ul>
                            <!-- end Tabs -->

                            <!--- Tab Contents --->
                            <div class="tab-content">

                              <!-- first tab --->
                              <div class="tab-pane fade active in" id="select">

                                <div class="col-md-4">
                                  <div class="portlet light bordered">
                                      <div class="portlet-title">
                                        <div class="caption font-red-sunglo">
                                                  <!--- <i class="icon-settings font-red-sunglo"></i> --->
                                                  <span class="caption-subject bold uppercase"> Content Groups</span>
                                        </div>
                                      </div>


                                      <div class="form-group">
                                          <div class="col-md-12">
                                              <div class="input-group">
                                                  <div class="input-icon">
                                                      <!--- <i class="fa fa-lock fa-fw"></i> --->
                                                      <input id="addGroup" class="form-control" type="text" placeholder="Add a new Group">
                                                  </div>

                                                  <span class="input-group-btn">
                                                    <div id="btn_addLocation" class="btn btn-success" type="button">
                                                    <i class="fa fa-arrow-left fa-fw"></i> Add</div>
                                                  </span>
                                              </div>
                                          </div>
                                      </div>


                                      <div class="portlet-body">

                                            <table class="table table-striped table-hover">
                                              <tbody id="location_list">
                                                <!--- <cfoutput query="q_content_groups">
                                                <tr>
                                                  <td class="click_location" data-id="#groupID#">#groupName#</td>
                                                </tr>
                                                </cfoutput> --->
                                              </tbody>
                                            </table>
                                      </div>
                                  </div><!--- Endn groups --->
                                </div><!-- ent column  1 --->


                                <div class="col-md-8">
                                  <!---  start list of group result ---->
                                  <div class="portlet light bordered">
                                      <div class="portlet-title">
                                        <div class="caption font-red-sunglo">
                                                  <i class="icon-settings font-red-sunglo"></i>
                                                  <span class="caption-subject bold uppercase"><span class="hd_groupList">Group</span> List</span>
                                        </div>

                                        <div class="actions">
                                                  <div class="btn-group">
                                                      <a class="btn btn-sm green dropdown-toggle" href="javascript:;" data-toggle="dropdown" aria-expanded="false"> Actions
                                                          <i class="fa fa-angle-down"></i>
                                                      </a>
                                                      <ul class="dropdown-menu pull-right">
                                                          <li>
                                                              <a href="javascript:void;" class="formLoad" data-id="0">
                                                                  <i class="fa fa-pencil"></i> New Content </a>
                                                          </li>
                                                      </ul>
                                                  </div>
                                              </div>
                                      </div>

                                      <div class="portlet-body">
                                        <table class="table table-striped table-hover" id="contentTable">
                                            <thead>
                                              <tr class="even">
                                                <th class="first" >Content</th>
                                                <th>Type</th>
                                                <th>Updated</th>
                                              </tr>
                                            </thead>
                                            <tbody id="group_list">
                                            </tbody>
                                        </table>
                                      </div>
                                </div>
                              </div><!--- end second column --->
                            </div><!--- end tab 1 --->


                              <div class="tab-pane fade" id="form">


                                <div class="portlet light bordered">
                                    <!--- <div class="portlet-title">
                                      <div class="caption font-red-sunglo">
                                                <i class="icon-settings font-red-sunglo"></i>
                                                <span class="caption-subject bold uppercase hd_contentTitle"></span>
                                      </div>
                                    </div> --->

                                    <form id="formContent" class="portlet-body form-horizontal">
                                        <input type="hidden" name="contentID" value="-1" />

                                              <div class="form-body">

                                                  <div class="alert alert-danger display-hide">
                                                      <button class="close" data-close="alert"></button> You have some form errors. Please check below.
                                                  </div>

                                                  <div class="alert alert-success display-hide">
                                                      <button class="close" data-close="alert"></button> Your form validation is successful!
                                                  </div>

                                                  <div class="col-md-4">


                                                    <div class="portlet-title">
                                                      <div class="caption font-red-sunglo">
                                                        <i class="icon-settings font-red-sunglo"></i>
                                                        <span class="caption-subject bold uppercase hd_contentTitle"></span>
                                                      </div>
                                                    </div>

                                                      <div class="form-group">
                                                            <label class="control-label col-md-2 ">Type</label>
                                                            <div class="col-md-9">
                                                                <div class="mt-radio-inline">
                                                                    <label class="mt-radio">
                                                                        <input name="contentType"  value="html" type="radio"> html
                                                                        <span></span>
                                                                    </label>
                                                                    <label class="mt-radio">
                                                                        <input name="contentType"  value="mail" type="radio"> email
                                                                        <span></span>
                                                                    </label>
                                                                    <label class="mt-radio mt-radio-disabled">
                                                                        <input name="contentType"  value="info" type="radio"> info
                                                                        <span></span>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                      <div class="form-group">
                                                          <label class="control-label col-md-2">Title</label>
                                                          <div class="col-md-10">
                                                              <input type="text" name="pageTitle" data-required="1" class="form-control" />
                                                          </div>
                                                      </div>

                                                      <div class="form-group">
                                                          <label class="col-md-2 control-label">Content name
                                                          </label>
                                                          <div class="col-md-10">
                                                                  <input type="text" name="contentName" class="form-control" placeholder="Content Name">
                                                          </div>
                                                      </div>

                                                      <div class="form-group">
                                                          <label class="control-label col-md-2">Subject</label>
                                                          <div class="col-md-10">
                                                              <input type="text" name="subject"  class="form-control" />
                                                          </div>
                                                      </div>

                                                      <div class="form-group">
                                                          <label class="control-label col-md-2">Description</label>
                                                          <div class="col-md-10">
                                                              <textarea name="description" class="form-control autosizeme"></textarea>
                                                          </div>
                                                      </div>
                                                  </div><!-- end column n1 --->



                                                  <div class="col-md-8">
                                                      <div class="form-group last">

                                                          <div class="col-md-12">
                                                              <textarea class="ckeditor form-control" name="contentBody" id="contentBody" rows="6" data-error-container="#editor_error"></textarea>
                                                              <div id="editor_error"> </div>
                                                          </div>
                                                      </div>
                                                  </div><!-- end column 2 --->
                                              </div><!--- end formbody --->

                                              <div class="form-actions">
                                                  <div class="row">
                                                      <div class=" col-md-8 pull-right">
                                                          <button type="submit" class="btn green">Save</button>
                                                          <!--- col-md-offset-3<button type="button" class="btn default">Cancel</button> --->
                                                      </div>
                                                      <div class="col-md-4">

                                                      </div>
                                                  </div>
                                              </div>
                                      </form>

                                </div>
                              </div>
                            </div>
                          </div>

                        </div>
                        <!--- END body row --->
                    </div>
                    <!-- END CONTENT BODY -->
                </div>
<!-- END CONTENT -->

<!--- <script src="_frame/content/app.js" type="text/javascript"></script> --->

<script>

// controller.init();
  // FormValidation.init();
</script>
