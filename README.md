---
title: "T.B. Hartman - cv colophon"
layout: default
---

Colophon for cirriculum vitae generation
========================================

Intro
-----

This document describes how I create and publish my CV.  Please feel free use and modify at your own risk, but I ask that you leave the following attribution in the source documents.  No attribution is needed in resulting rendered documents, nor the HTML source (although it is nice if you can).

    (c) 2012-2014 Timothy B. Hartman <tbhartman@gmail.com>
    http://tbhartman.org
    
    
    You may use use this document as a template to create your own CV
    and you may redistribute the source code freely.  No attribution is
    required in any resulting documents.  I do ask that you please leave
    this notice and the above URL in the source code if you choose to
    redistribute this file.

I must acknowledge that the original LaTeX format was taken from [Jason Blevins](http://jblevins.org):

    Copyright (C) 2004-2014 Jason R. Blevins <jrblevin@sdf.org>
    http://jblevins.org/

with the same request for acknowledgement.

Data
----

The data for the CV lives in [an XML file](/cv/cv.xml).  An associated [XSL](/cv/cv.xsl) file describes the translation from XML to HTML.  If you have scripting enabled in a modern browser, it will automatically apply the translation and display the resulting (rendered) HTML document.  Finally, [a stylesheet](/cv/cv.css) controls final formatting.

Additionly, [a second XSL](/cv/cv.tex.xsl) document provides the translation to LaTeX, from which [a PDF](/cv/cv.pdf) is made for distribution.

Source
------

The current source can be found at [my GitHub site](http://github.com/tbhartman/cv).  I have versioned the resulting PDF and HTML files.
