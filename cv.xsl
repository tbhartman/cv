<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns='http://www.w3.org/1999/xhtml' >
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <!--
      doctype="'-//W3C//DTD XHTML 1.1 plus MathML 2.0 plus SVG 1.1//EN'
      'http://www.w3.org/2002/04/xhtml-math-svg/xhtml-math-svg.dtd'"
      media-type="text/html"/>
    -->


<xsl:template match="vitae">
    <!--
  <xsl:text disable-output-escaping="yes">
&lt;!DOCTYPE html
    PUBLIC '-//W3C//DTD XHTML 1.1 plus MathML 2.0 plus SVG 1.1//EN'
    'http://www.w3.org/2002/04/xhtml-math-svg/xhtml-math-svg.dtd'/&gt;
  </xsl:text>
  -->
<html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'>
<head>
    <meta name='viewport' content='width=device-width'/>
    <meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>
    <link rel='stylesheet' type='text/css' href='cv.css'/>
    <title><xsl:value-of select="profile/shortname"/> -- cirriculum vitae</title>
</head>
  <body>
    <!--
  <xsl:text disable-output-escaping="yes">
      
  </xsl:text>
  <xsl:value-of select="boilerplate"/>
  <xsl:text disable-output-escaping="yes">
      
  </xsl:text>
  -->
<div id="cv">
      <h1><xsl:value-of select="profile/fullname"/></h1>
  <!--
      <div id="profile">
        <xsl:apply-templates select="profile/contact"/>
      </div>
      <xsl:apply-templates select="education/school"/>
  -->
      <xsl:apply-templates/>
</div>
  </body>
  </html>
</xsl:template>

<xsl:template match="boilerplate">
</xsl:template>

<xsl:template match="profile">
  <div id="profile">
    <xsl:apply-templates select="contact[@type='work']"/>
  </div>
</xsl:template>

<xsl:template match="//contact[@type='work']">
  <div id="address">
    <xsl:value-of select="department"/><br />
    <xsl:value-of select="company"/><br />
    <xsl:value-of select="address/number"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:value-of select="address/street"/><br />
    <xsl:value-of select="address/city"/>,
    <xsl:value-of select="address/state"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:value-of select="address/code"/>
  </div>
  <div id="contact">
    Mobile: <xsl:value-of select="phone[@type='mobile']"/><br />
    <!--Work: <xsl:value-of select="phone[@type='work']"/><br />-->
    Email: <a href="mailto:{email}"><xsl:value-of select="email"/></a><br />
  </div>
</xsl:template>

<xsl:template match="education">
  <div id="education">
    <h2>Education</h2>
    <xsl:apply-templates select="school"/>
  </div>
</xsl:template>
<xsl:template match="employment">
  <div id="{@type}" class="employment">
    <h2><xsl:value-of select="@type"/></h2>
    <xsl:apply-templates select="job"/>
  </div>
</xsl:template>
<xsl:template match="job">
  <div class="job">
    <h3><xsl:value-of select="company"/></h3>
    <span class="department"><xsl:value-of select="department"/></span>
    <span class="location"><xsl:value-of select="location"/></span>
    <xsl:apply-templates select="position"/>
  </div>
</xsl:template>
<xsl:template match="job/position">
  <div class="job">
    <h4><xsl:value-of select="title"/></h4>
    <div class="description">
       <xsl:value-of select="description"/>
    </div>
  </div>
</xsl:template>
<xsl:template match="awards">
  <div id="awards">
    <h2>Awards and Honors</h2>
    <ul>
      <xsl:for-each select="item">
        <li><xsl:value-of select="."/></li>
      </xsl:for-each>
    </ul>
  </div>
</xsl:template>
<xsl:template match="research">
  <div id="research">
    <h2>Research</h2>
    <xsl:if test="article">
      <div>
      <h3>Journal Articles</h3>
        <xsl:apply-templates select="article"/>
      </div>
    </xsl:if>
    <xsl:if test="proceedings">
      <div>
      <h3>Conference Proceedings</h3>
        <xsl:apply-templates select="proceedings"/>
      </div>
    </xsl:if>
    <xsl:if test="presentation">
      <div>
      <h3>Presentations</h3>
        <xsl:apply-templates select="presentation"/>
      </div>
    </xsl:if>
  </div>
</xsl:template>
<xsl:template match="author">
  <xsl:if test="@self">
    <span class="self"><xsl:value-of select="."/></span>
  </xsl:if>
  <xsl:if test="not(@self)">
    <span><xsl:value-of select="."/></span>
  </xsl:if>
</xsl:template>
<xsl:template match="article|proceedings">
  <div class="publication">
    <!-- authors -->
    <xsl:if test="count(author)=1">
        <xsl:apply-templates select="author"/>
    </xsl:if>
    <xsl:if test="count(author)=2">
        <xsl:apply-templates select="author[1]"/>
      and
        <xsl:apply-templates select="author[2]"/>
    </xsl:if>
    <xsl:if test="count(author)>2">
      <xsl:for-each select="author[position()&lt;last()]">
        <xsl:apply-templates select="."/>,
      </xsl:for-each>
      and
      <xsl:apply-templates select="author[last()]"/>
    </xsl:if>.
    <!-- end authors -->
    "<xsl:value-of select="title"/>."
    <em><xsl:value-of select="journal"/></em>.
    <xsl:if test="volume">
      <xsl:value-of select="volume"/>.<xsl:value-of select="issue"/>
    </xsl:if>
    <xsl:value-of select="date"/>
    <xsl:if test="pages">
      (pp. <xsl:value-of select="pages"/>)
    </xsl:if>
  </div>
</xsl:template>
<xsl:template match="presentation">
  <div class="presentation">
    <span class="title"><xsl:value-of select="title"/></span><br />
    <span class="event"><xsl:value-of select="event"/></span>,
    <span class="location"><xsl:value-of select="location"/></span>,
    <span class="date"><xsl:value-of select="date"/></span>.
  </div>
</xsl:template>
<xsl:template match="activity[position()=1]">
  <div id="activities">
    <h2>Activities</h2>
    <xsl:for-each select="/vitae/activity">
      <div class="activity">
        <h3><xsl:value-of select="@type"/></h3>
        <table>
          <xsl:apply-templates select="item"/>
        </table>
      </div>
    </xsl:for-each>
  </div>
</xsl:template>
<xsl:template match="activity[position()>1]">
</xsl:template>
<xsl:template match="//activity/item">
  <tr>
    <td class="task"><xsl:value-of select="task"/></td>
    <td class="location"><xsl:value-of select="location"/></td>
    <td class="date"><xsl:value-of select="date"/></td>
  </tr>
</xsl:template>

<xsl:template match="//education/school">
  <div class="school">
    <span class="degree"><xsl:value-of select="degree"/></span>,
    <xsl:value-of select="name"/>,
    <xsl:if test="finish[@tbd='1']">
      <span class="finish">
        <span class="tbd">anticipated <xsl:value-of select="finish"/></span>
      </span>
    </xsl:if>
    <xsl:if test="not(finish[@tbd='1'])">
      <span class="finish"><xsl:value-of select="finish"/></span>
    </xsl:if>

    <xsl:if test="gpa">
      <em id="gpa">(GPA: <xsl:value-of select="gpa"/>)</em>
    </xsl:if>
    <xsl:if test="note | thesis | committee">
      <div>
        <ul>
          <xsl:apply-templates select="note|thesis|committee"/>
          <xsl:for-each select="committee">
          </xsl:for-each>
        </ul>
      </div>
    </xsl:if>
  </div>
</xsl:template>

<xsl:template match="note | thesis">
  <li>
  <xsl:if test="@type">
    <em><xsl:value-of select="@type"/>:</em>
  </xsl:if>
    <xsl:value-of select="."/>
  </li>
</xsl:template>
<xsl:template match="committee">
  <li>
    Committee:
    <div id="committee">
      <ul>
        <xsl:for-each select="member">
          <li>
            <xsl:value-of select="."/>
          </li>
        </xsl:for-each>
      </ul>
    </div>
  </li>
</xsl:template>

</xsl:stylesheet>
