<!DOCTYPE html>
<html lang="${.lang}">
<head>
  <#include "libs/head.ftl">
  <link rel="stylesheet" href="/assets/libs/node_modules/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css"></link>
  <title>${config.name!""} | <@message "data-access-history"/> ${dar.id}</title>
</head>
<body id="data-access-history-page" class="hold-transition sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">

  <!-- Navbar -->
    <#include "libs/aside-navbar.ftl">
  <!-- /.navbar -->

  <!-- Sidebar -->
    <#include "libs/data-access-sidebar.ftl">
  <!-- /.sidebar -->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header bg-info mb-4">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-6">
            <h1 class="m-0">
              <span class="text-white-50"><@message "data-access-history"/> /</span> ${dar.id}
            </h1>
          </div>
          <div class="col-sm-6">
              <#include "libs/data-access-breadcrumb.ftl">
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">

      <#if dataAccessCalloutsEnabled>
        <div class="row">
          <div class="col-12">
            <div class="callout callout-info">
              <p>
                <@message "data-access-history-callout"/>
              </p>
            </div>
          </div>
          <!-- /.col-12 -->
        </div>
        <!-- /.row -->
      </#if>

      <div class="row">
        <div class="col-sm-12 col-lg-6">
          <div class="card card-info card-outline">
            <div class="card-header">
              <h3 class="card-title"><@message "status-changes"/></h3>
            </div>
            <div class="card-body">
              <table id="status" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <#if accessConfig.amendmentsEnabled>
                    <th><@message "form"/></th>
                  </#if>
                  <th><@message "status"/></th>
                  <th><@message "author"/></th>
                  <th><@message "date"/></th>
                </tr>
                </thead>
                <tbody>
                <#list statusChangeEvents?reverse as event>
                  <tr>
                    <#if accessConfig.amendmentsEnabled>
                      <td>
                        <#if event.amendment>
                          <a href="../data-access-amendment-form/${event.form.id}"><i class="fas fa-file-import"></i> ${event.form.id}</a>
                        <#elseif event.feasibility>
                          <a href="../data-access-feasibility-form/${event.form.id}"><i class="far fa-question-circle"></i> ${event.form.id}</a>
                        <#else>
                          <a href="../data-access-form/${event.form.id}"><i class="fas fa-book"></i> ${event.form.id}</a>
                        </#if>
                      </td>
                    </#if>
                    <td><i class="fas fa-circle text-${statusColor(event.status.toString())}"></i> <@message event.status.toString()/></td>
                    <td>${event.profile.fullName}</td>
                    <td data-sort="${event.date.toString(datetimeFormat)}" class="moment-datetime">${event.date.toString(datetimeFormat)}</td>
                  </tr>
                </#list>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <!-- /.col-6 -->
        <#if isAdministrator || isDAO>
          <div class="col-sm-12 col-lg-6">
            <div class="card card-info card-outline">
              <div class="card-header">
                <h3 class="card-title">Action Log</h3>
                <div class="float-right"><a href="#" class="btn btn-primary" data-toggle="modal" data-target="#modal-add"><i class="fas fa-plus"></i> <@message "add"/></a></div>
              </div>
              <div class="card-body">
                <table id="actions" class="table table-bordered table-striped">
                  <thead>
                  <tr>
                    <th><@message "action"/></th>
                    <th><@message "author"/></th>
                    <th><@message "date"/>></th>
                  </tr>
                  </thead>
                  <tbody>
                  <#list dar.actionLogHistory as act>
                    <tr>
                      <td>${act.action}</td>
                      <td>${act.author}</td>
                      <td data-sort="${act.changedOn.toString(datetimeFormat)}" class="moment-date">${act.changedOn.toString(datetimeFormat)}</td>
                    </tr>
                  </#list>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </#if>
        <!-- /.col-6 -->
      </div>
      <!-- /.row -->

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Action addition modal -->
  <div class="modal fade" id="modal-add">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title"><@message "add-action"/></h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <label><@message "action"/></label>
            <input type="text" id="action-text" class="form-control">
          </div>
          <div class="form-group">
            <label><@message "date"/></label>
            <div class="input-group">
              <input type="text" id="action-date" class="form-control">
              <div class="input-group-append">
                <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-between">
          <button type="button" class="btn btn-default" data-dismiss="modal"><@message "cancel"/></button>
          <button type="button" class="btn btn-primary" id="action-add-submit"><@message "submit"/></button>
        </div>
      </div>
      <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
  </div>
  <!-- /.modal -->

  <#include "libs/footer.ftl">

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<#include "libs/scripts.ftl">
<!-- Datepicker -->
<script src="/assets/libs/node_modules/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<script>
    $(function () {
        $('#history-menu').addClass('active').attr('href', '#')
        $("#status").DataTable(dataTablesNoSortSearchOpts);
        $("#actions").DataTable(dataTablesNoSortSearchOpts);
        $('#action-date').datepicker({
          locale: '${.lang}',
          format: 'yyyy-mm-dd'
        });
        $('#action-add-submit').click(function() {
          let action = {
            text: $('#action-text').val(),
            date: $('#action-date').val()
          };
          micajs.dataAccess.addAction('${dar.id}', action);
        });
    });
</script>
</body>
</html>
