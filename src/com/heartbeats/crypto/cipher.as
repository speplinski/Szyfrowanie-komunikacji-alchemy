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

package com.heartbeats.crypto 
{

import flash.utils.ByteArray;
import cmodule.cipher.CLibInit;

public class cipher 
{
	protected static const _lib_init : cmodule.cipher.CLibInit = new cmodule.cipher.CLibInit ();
	protected static const _lib : Object = _lib_init.init ();
	
	/**
	 * Calling this method resets all existing data.
	 * 
	 * @return Unique numeric identifier for the process.
	 */
	static public function begin () : uint 
	{
		return _lib.begin ();
	}
	
	/**
	 * Update instruction mode.
	 * 
	 * @param hdl Unique numeric identifier for the process.
	 * @param data The raw data.
	 * @return Ciphertext digits.
	 */ 
	static public function update ( hdl : uint, data : ByteArray ) : ByteArray 
	{
		return _lib.update ( hdl, data );
	}
	
	/**
	 * Flushes any accumulated data in the output buffer.
	 * 
	 * @param hdl Unique numeric identifier for the process.
	 * @return Encrypted information.
	 */
	static public function finish ( hdl : uint ) : ByteArray 
	{
		return _lib.finish ( hdl );
	}
}
}
