      * ------------------------------------------------------------- *
      * This sample shows the use of the buildin XML parser in
      * IceBreak
      *
      * Look at the header source file "qAspHdr" in the IceBreak   library
      * for a complete description of the functionality
      *
      * The aim is to produce a XML document from scratch
      *
      * Step 1)
      * When using the XML parser - always bind your program to the XMLPARSER
      * bind directory - either by the CRTPGM command or add the "H" spec below:
      *
      * Step 2)
      * Include the prototypes for the xml parser found in member "XMLPARSER"
      * in the source file "qAspHdr" in the IceBreak   library
      *
      * Step 3)
      * Parse your XML file by caling the "XML_Parse" function. It returns
      * logical a pointer to an XML object tree.
      * Examine if the parser ran ok with xml_Error() which return *ON if an
      * error did occur. In that case you can examine the reason with
      * the function "XML_GetMsg()" to retrive the error and/or
      * use the function "XML_Dump()"   to display the xml-tree contents
      *
      * Step 4)
      * Locate each element node by the function "XML_Locate".
      * the location can be relative or from the root by prefixinig the location
      * with an "/". Each level is separated by a "/" e.g.
      * "/MyRoot/MyElement"  is "myelement" found within "myroot"
      *
      * Step 5)
      * When a element node is sucessfully fetched, you can write
      * a new XML document with this element as a root element.
      * Use the XML_writeStmf(pElm: FileName : Ccsid)  to produce that task
      * the ccsid can be other than the source XMl document. it will
      * convert it to the selected ccsid. Note: Comments not reproduced.
      *
      * Step 6)
      * Last - remember to close the XML tree with "XML_Close"
      *
      *
      * The XML file we want to parse in this sample look like:
      *
      *   <?xml version="1.0" encoding="ISO-8859-1"?>
      *   <root>
      *      <first>
      *        <subnode2>Sub stuff</subnode2>
      *      <first>
      *      <last>Some stuff<last>
      *   </root>
      * ------------------------------------------------------------- *
     H BndDir('XMLPARSER') dftactgrp(*NO) ACTGRP('QILE' )
     D pXml            s               *
     D pElem           s               *
     D pPanel          s               *
     D msg             s             50    varying
     D tag             s             50    varying
     D value           s             50    varying
      /include qAspHdr,xmlparser
      /free
        // first we run the paser on a minimal string to build the XML tree with the root name "root"
        pXml = xml_ParseFile ('/bwr/mf/utf-16.xml' :'syntax=LOOSE');
        if Xml_Error(pXml) ;
           msg = xml_Message(pXml);
           xml_Close(pXml);
           return;
        endif;

        xml_dump(pXml);

        xml_writeStmf(pXml : '/bwr/mf/utf-8.xml' : 1208);
        xml_Close(pXml);
        *inlr = *on;
