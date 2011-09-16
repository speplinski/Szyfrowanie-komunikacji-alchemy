<?php

/* This file is part of the "Szyfrowanie przesyłania wyników gier" project.
 * http://lab.180hb.com/2010/07/szyfrowanie-komunikacji-klient-serwer-alchemy/
 *
 * Copyright (c) 2011 LAB^180 (http://lab.180hb.com).
 *
 * @author Szymon P. Peplinski (speplinski@180hb.com)
 *
 * This code is licensed to you under the terms of the Creative Commons 
 * Attribution–Share Alike 3.0 Unported license ("CC BY-SA 3.0").
 * An explanation of CC BY-SA 3.0 is available at 
 * http://creativecommons.org/licenses/by-sa/3.0/.
 *
 * The original authors of this document, and LAB^180, 
 * designate this project as the "Attribution Party" 
 * for purposes of CC BY-SA 3.0.
 *
 * In accordance with CC BY-SA 3.0, if you distribute this document 
 * or an adaptation of it, you must provide the URL 
 * for the original version.
 */

?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>180heartbeats - Sample Decription</title>
</head>
<body>
	<form action="<?php echo $_SERVER [ 'REQUEST_URI' ]; ?>" method="post">
		Encrypted information:<br />
		<textarea rows="4" cols="60" name="cipher"><?php echo $_POST [ 'cipher' ]; ?></textarea><br />
		<input type="submit" value="Submit" /><br />
		<?php
			if ( isset ( $_POST [ 'cipher' ] ) )
			{
				$hex = $_POST [ 'cipher' ];
				$decrypted = 'Argument is not a hex';
				
				$cipher = mcrypt_module_open ( MCRYPT_RIJNDAEL_128, '', MCRYPT_MODE_CBC, '' );
				$key = pack ( "H*", '6369706865724031383068622E636F6D' );
				
				$s = mcrypt_generic_init ( $cipher, $key, $key );
				
				if ( ( $s < 0 ) || ( $s === false ) )
				{
					//die ( "Really an error" );
				}
				else
				{
					if ( preg_match ( '/^[0-9A-F]*$/i', $hex ) )
					{
						$data = pack ( "H*", $hex );
						
						if ( $data )
						{
							$decrypted = mdecrypt_generic ( $cipher, $data );
							mcrypt_generic_deinit ( $cipher );
						}
					}
				}
				
				echo '<br />Decoded information:<br /><pre>';
				print_r ( explode ( ';', $decrypted ) );
				echo '</pre><br />';
			}
		?>
	</form>
</body>
</html>