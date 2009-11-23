<h2>Can LightFront handle search engine safe (SES) URL's?</h2>
<p>Yes, some experimentation with mod_rewrites have produced satisfactory results with LightFront applications.</p>
<p>The following settings have worked with Apache 2.2, but are not officially supported in the framework:</p>
<dt>
	<dd>RewriteEngine on</dd>
	<dd>RewriteLog logs/lightfront-rewrite_log</dd>
	<dd>RewriteRule ^/do/([A-Za-z0-9-]+)/([A-Za-z0-9-]+)/([A-Za-z0-9-]+) /index.cfm?do=$1.$2.$3 [PT,L]</dd>
	<dd>RewriteRule ^/do/([A-Za-z0-9-]+)/([A-Za-z0-9-]+) /index.cfm?do=$1.$2 [PT,L]</dd>
	<dd>RewriteRule ^/do/([A-Za-z0-9-]+)/?$ /index.cfm?do=$1 [PT,L]</dd>
</dt>
<p><strong>Note:</strong> You do not have to have index.cfm in your URL with these settings. A similar ISAPI_rewrite setting should also work, but has not yet been tested.</p>