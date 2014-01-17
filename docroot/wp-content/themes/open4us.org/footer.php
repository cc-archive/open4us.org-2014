<?php
/**
 * The template for displaying the footer.
 *
 * Contains the closing of the id=main div and all content after
 *
 * @package WordPress
 * @subpackage Twenty_Eleven
 * @since Twenty Eleven 1.0
 */
?>

	</div><!-- #main -->

	<footer id="colophon" role="contentinfo">

	  <?php
	     /* A sidebar in the footer? Yep. You can can customize
	     * your footer with three columns of widgets.
	     */
	     get_sidebar( 'footer' );
	     ?>
	  
	  <div id="site-generator">
	    <div id="footer_interior">
	      <p>
		<a href="http://www.gatesfoundation.org/postsecondaryeducation/Pages/default.aspx">
		  Funded by the Bill & Melinda Gates Foundation
		</a>
	      </p>
	      <p class="license_info">
		<a href="http://creativecommons.org/licenses/by/4.0/"
		   class="license_icon"
		   title="Creative Commons Attribution 4.0 International License">
		  <img src="http://i.creativecommons.org/l/by/4.0/88x31.png" alt="License">
		</a>
		<div class="license_text_info" 
		     xmlns:cc="http://creativecommons.org/ns#" about="http://open4us.org">
		  Except where otherwise noted, content on <span property="cc:attributionName" content="Open Professionals Education Network"></span><span property="cc:attributionURL" content="http://open4us.org">this site</span> is licensed<br/>under a <a xmlns:xh="http://www.w3.org/1999/xhtml/vocab#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" rel="xh:license license" href="http://creativecommons.org/licenses/by/4.0/" class="subfoot">Creative Commons Attribution 4.0 International License</a>
		</div>
	      </p>

<!--	      <div>
		Funded by the Bill & Melinda Gates Foundation
	      </div>

	      <div style="line-height: 1em;">
		<div style="display: block;
			    font-size: 10px;
			    font-family: sans;
			    width: 200px;
			    " 
		       xmlns:cc="http://creativecommons.org/ns#" 
		       about="http://open4us.org">
		    <small>Except where otherwise noted, content on <span property="cc:attributionName" content="Open Professionals Education Network"></span><span property="cc:attributionURL" content="http://open4us.org">this site</span> is licensed under a <a xmlns:xh="http://www.w3.org/1999/xhtml/vocab#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" rel="xh:license license" href="http://creativecommons.org/licenses/by/4.0/" class="subfoot">Creative Commons Attribution 4.0 International License</a></small>
		  </div>
		</p>
		<p>
		  <a href="http://creativecommons.org/licenses/by/4.0/" title="Creative Commons Attribution 4.0 International License">
		  <img src="http://i.creativecommons.org/l/by/4.0/88x31.png" alt="License">
		</a>
		</p>
	      </div>
-->
	    </div>	    
	  </div>
	</footer><!-- #colophon -->
</div><!-- #page -->

<?php wp_footer(); ?>

</body>
</html>
