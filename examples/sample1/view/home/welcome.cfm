<cfoutput>
<div id="main" style="width: 100%;">
	<div id="main_right">
		<div><em>This application was written in LightFront!</em></div>
		<p><a href="downloads/lightfront.zip"><strong>Download</strong></a> (.zip)</p>
		<p><a href="http://test.lightfront.org/skeleton/">View the LightFront skeleton application</a></p>
		<p><a href="http://svn.lightfront.org/svn/lightfront">Browse the LightFront SVN repository</a></p>
		<form action="http://groups.google.com/group/lightfront/boxsubscribe">
			<table id="googlegroup">
				<tr>
					<td align="right" class="googlegroupheader"><strong>Subscribe to the LightFront Google Group</strong></td>
				</tr>
				<tr>
					<td align="right" class="googlegroupcell">Email: <input type="text" name="email" /></td>
				</tr>
				<tr>
					<td align="right">
						<input type="submit" name="sub" value="Subscribe" />
					</td>
				</tr>
				<tr>
					<td align="center"><a href="http://groups.google.com/group/lightfront">Visit this group</a></td>
				</tr>
			</table>
		</form>
		<p>Follow <a href="http://twitter.com/lightfront">@LightFront on Twitter!</a> <i>(announcements only)</i></p>
		<p>If you like LightFront, help support work on the framework by buying something off of <a href="http://www.amazon.com/gp/registry/wishlist/2F8KHYCQT906Z/ref=wl_web">my Amazon wishlist</a> or <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=podcast%40cfconversations%2ecom&no_shipping=0&no_note=1&tax=0&currency_code=USD&lc=US&bn=PP%2dDonationsBF&charset=UTF%2d8">make a Paypal donation</a>.</p>
		#displayView("home/plugs")#
	</div>
	<div id="main_left">
		<h2 style="margin-top: 2px;">Welcome to the homepage of the &quot;sample1&quot; application for the LightFront Framework!</h2>
		<p>This serves as a temporary homepage for the LightFront Framework, as well as answer some questions about LightFront and how to do certain things within the framework.</p>
		#displayView("faq/faq")#
	</div>
</div>
<div style="clear: both;"></div>
</cfoutput>
