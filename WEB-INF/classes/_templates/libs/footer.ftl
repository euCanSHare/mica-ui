<!-- Main Footer -->
<footer class="main-footer d-print-none">
  <!-- To the right -->
  <#if config??>
    <div class="float-right d-none d-sm-inline border-left pl-2 ml-2">
      <strong><@message "copyright"/> &copy; 2020 <a href="${config.portalUrl!"#"}">${config.name!""}</a>.</strong> <@message "all-rights-reserved"/>
    </div>
  </#if>
  <!-- <a href="/admin" title="<@message "administration"/>" class="float-right"><i class="fas fa-lock"></i></a> -->
  <!-- <a class="float-right" href="https://dev-agate.eucanshare.bsc.es/auth/signin/eush-dev?redirect=https%3A%2F%2Fdev-mica.eucanshare.bsc.es/admin&signin_error=https%3A%2F%2Fdev-mica.eucanshare.bsc.es%2Fsignup-with"><i class="fas fa-lock"></i></a> -->
  <a class="float-right" href="/admin<#if rc.requestUri != "/" && !rc.requestUri?starts_with("/forgot-password") && !rc.requestUri?starts_with("/just-registered") && !rc.requestUri?starts_with("/error") && !rc.requestUri?starts_with("/signin")>?redirect=${rc.requestUri}</#if>"><i class="fas fa-lock"></i></a>  
  
  <!-- Default to the left -->
  <small><@message "powered-by"/> <a href="https://www.obiba.org">OBiBa Mica</a></small>
</footer>
