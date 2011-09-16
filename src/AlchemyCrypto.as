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

package
{

import flash.display.Sprite;
import flash.events.Event;
import flash.utils.ByteArray;

import mx.utils.UIDUtil;

import com.heartbeats.crypto.cipher; 

[ SWF ( width = '320', height = '240', backgroundColor = '#FFFFFF', frameRate = '30' ) ]

/**
 * Class allow transforming information (referred to as plaintext) using an algorithm (called cipher) 
 * to make it unreadable to anyone except those possessing special knowledge, referred to as a key. 
 * The result of the process is encrypted information.
 * 
 * @langversion ActionScript 3.0
 * @playerversion Flash 10.0
 * 
 * @author Szymon Peplinski
 */
public class AlchemyCrypto extends Sprite
{
	/**
	 * @constructor
	 */
	public function AlchemyCrypto ()
	{
		super ();
		
		if ( this.stage )
		{
			this._initialize ();
		}
		else
		{
			this.addEventListener ( Event.ADDED_TO_STAGE, this._initialize )
		}
	}

	/**
	 * Initialize stub.
	 * 
	 * @param event The Event object that is dispatched into the event flow. 
	 * If the event is being redispatched, a clone of the event is created automatically. 
	 * After an event is dispatched, its target property cannot be changed, 
	 * so you must create a new copy of the event for redispatching to work.
	 */
	private function _initialize ( event : Event = null ) : void
	{
		this.stage.removeEventListener ( Event.ADDED_TO_STAGE, this._initialize );
		
		var input : String = "";
		
		// Adding some string.
		input = input + "zażółćgęśląjaźń" + ";";
		
		// Adding some integer.
		input = input + 123 + ";";
		
		// Adding some float.
		input = input + Math.PI + ";";
		
		// Adding unique id.
		input = input + UIDUtil.createUID () + ";";
		
		var output : String = this._encrypt ( input );
		
		throw Error ( "\nInput = " + input + "\nOutput = " + output );
	}
	
	/**
	  * Encrypts the data.
	  * 
	  * @param data The raw data.
	  * @param colons Colon hexadecimal notation.
	  * 
	  * @return Encrypted information.
	  */
	private function _encrypt ( data : String, colons : Boolean = false ) : String
	{
		var buffer : ByteArray = new ByteArray;
		buffer.writeUTFBytes ( data );
		
		var handler : uint = cipher.begin ();
		
		var encrypted : ByteArray = cipher.update ( handler, buffer );
		encrypted.writeBytes ( cipher.finish ( handler ) );
		
		return this._fromArray ( encrypted, colons );
	}
	
	/**
	 * Converts the byte array to a string.
	 * 
	 * @param array The byte stream.
	 * @param colons Colon hexadecimal notation.
	 * 
	 * @return The string representation of the byte array.
	 */
	private function _fromArray ( array : ByteArray, colons : Boolean = false ) : String 
	{
		var string : String = "";
		var i : int;
		
		for ( i = 0; i < array.length; i ++ ) 
		{
			string += ( "0" + array [ i ].toString ( 16 ) ).substr ( -2, 2 );
			
			if ( colons ) 
			{
				if ( i < array.length - 1 ) string += ":";
			}
		}
		
		return string;
	}
}

}
