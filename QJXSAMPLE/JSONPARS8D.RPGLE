      * ------------------------------------------------------------- *
      * This sample shows the use of the buildin JSONparser in
      * IceBreak
      *
      * Look at the header source file "qAspHdr" in the IceBreak   library
      * for a complete description of the functionality
      *
      * The aim is to produce a JSONdocument from scratch
      *
      * Step 1)
      * When using the JSONparser - always bind your program to the XMLPARSER
      * bind directory - either by the CRTPGM command or add the "H" spec below:
      *
      * Step 2)
      * Include the prototypes for the JSONparser found in member "XMLPARSER"
      * in the source file "qAspHdr" in the IceBreak   library
      *
      * Step 3)
      * Parse your JSONfile by caling the "json_Parse" function. It returns
      * logical a pointer to an JSON object tree.
      * Examine if the parser ran ok with json_Error() which return *ON if an
      * error did occur. In that case you can examine the reason with
      * the function "json_GetMsg()" to retrive the error and/or
      * use the function "json_Dump()"   to display the xml-tree contents
      *
      * Step 4)
      * Locate each element node by the function "json_Locate".
      * the location can be relative or from the root by prefixinig the location
      * with an "/". Each level is separated by a "/" e.g.
      * "/MyRoot/MyElement"  is "myelement" found within "myroot"
      *
      * Step 5)
      * When a element node is sucessfully fetched, you can write
      * a new JSON document with this element as a root element.
      * Use the json_writeStmf(pElm: FileName : Ccsid)  to produce that task
      * the ccsid can be other than the source JSON document. it will
      * convert it to the selected ccsid. Note: Comments not reproduced.
      *
      * Step 6)
      * Last - remember to close the JSON tree with "json_Close"
      *
      *
      * ------------------------------------------------------------- *
     H BndDir('XMLPARSER') dftactgrp(*NO) ACTGRP('QILE' )
     D pJson           s               *
     D p               s               *
     D msg             s             50    varying
     D s               s             50    varying
     D n               s             50    varying
     D i               s             10I 0
      /include qAspHdr,JSONparser
      /free

        // First demo: find attribues which contains objects where attibutes has a value
        pJson = json_ParseString ('{e:{ -
          "a": { "x":1 , "y":"11"}, -
          "b": { "x":2 , "y":"22"}, -
          "c": { "x":3 , "y":"33"}  -
        }}');

        if json_Error(pJson) ;
           msg = JSON_Message(pJson);
           JSON_dump(pJson);
           JSON_Close(pJson);
           return;
        endif;

        // Get the object in the array where the "x" attribute has the value of 2
        p = json_locate  (pJson : '/e[x=2]');
        n = json_getName(p); // the is the "b" object
        s = json_getStr      (p : 'y' );

        JSON_Close(pJson);
        // Next demo: find attribues in arrays where attibutes has a value
        pJson = json_ParseString ('{e:[ -
          { "x":1 , "y":"11"}, -
          { "x":2 , "y":"22"}, -
          { "x":3 , "y":"33"}  -
        ]}');

        if json_Error(pJson) ;
           msg = json_Message(pJson);
           json_dump(pJson);
           json_Close(pJson);
           return;
        endif;

        // Get the object in the array where the "x" attribute has the value of 2
        p = json_locate  (pJson : '/e[x=2]');
        n = json_getName(p); // This object has no name since it is an element of an array
        s = json_getStr      (p : 'y' );

        *inlr = *on;
