<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  extension-element-prefixes="str">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="vitae">
    <TeXML emptylines="1" ligatures="1">
      <TeXML escape="0" ligatures="1">
        <xsl:text>
% This LaTeX document is automatically generated from XML via XSLT
        </xsl:text>
      </TeXML>
      <xsl:apply-templates select="boilerplate"/>
      <xsl:call-template name="preamble"/>
      <env name="document">
          <xsl:apply-templates select="profile"/>
          <xsl:apply-templates select="education"/>
          <xsl:apply-templates select="employment"/>
          <xsl:apply-templates select="research"/>
          <xsl:apply-templates select="awards"/>
          <xsl:if test="activity">
            <cmd name="clearpage" gr="0" nl2="1"/>
            <cmd name="section*" nl2="1">
              <parm>Activities</parm>
            </cmd>
            <xsl:apply-templates select="activity"/>
          </xsl:if>
      </env>
    </TeXML>
  </xsl:template>

  <xsl:template match="boilerplate">
    <xsl:call-template name="tex_comment">
      <xsl:with-param name="text">
        <xsl:value-of select="."/>
      </xsl:with-param>
    </xsl:call-template>
    <TeXML escape="0" ligatures="1"><xsl:text>
%----------------------------------------------------------------------%
      </xsl:text>
      </TeXML>
  </xsl:template>
  <xsl:template match="profile">
      <group>
          <cmd name="huge" gr="0"/>
          <xsl:value-of select="fullname"/>
      </group>

     
      <cmd name="bigskip" gr="0"/>
      <spec cat="nl"/>
      <spec cat="nl"/>
      <env name="minipage">
        <opt>t</opt>
        <parm>0.5<cmd name="textwidth" gr="0"/></parm>
        <xsl:value-of select="contact[@type='work']/department"/>
        <spec cat="esc"/><spec cat="esc"/>
        <spec cat="nl"/>
        <xsl:value-of select="contact[@type='work']/company"/>
        <spec cat="esc"/><spec cat="esc"/>
        <spec cat="nl"/>
        <xsl:value-of select="contact[@type='work']/address/number"/>
        <spec cat="space"/>
        <xsl:value-of select="contact[@type='work']/address/street"/>
        <spec cat="esc"/><spec cat="esc"/>
        <spec cat="nl"/>
        <xsl:value-of select="contact[@type='work']/address/city"/>,
        <xsl:value-of select="contact[@type='work']/address/state"/>
        <xsl:value-of select="contact[@type='work']/address/code"/>
      </env>
      <env name="minipage">
        <opt>t</opt>
        <parm>0.5<cmd name="textwidth" gr="0"/></parm>
        <cmd name="raggedleft" gr="0" nl2="1"/>
        <xsl:if test="contact[@type='work']/phone[@type='mobile']">
          Mobile:<spec cat="space"/><xsl:value-of select="contact[@type='work']/phone[@type='mobile']"/>
          <spec cat="esc"/><spec cat="esc"/>
          <spec cat="nl"/>
        </xsl:if>
        <xsl:if test="contact[@type='work']/phone[@type='office']">
          Office:<spec cat="space"/><xsl:value-of select="contact[@type='work']/phone[@type='office']"/>
          <spec cat="esc"/><spec cat="esc"/>
          <spec cat="nl"/>
        </xsl:if>
        <xsl:if test="contact[@type='work']/email">
          Email:<spec cat="space"/>
            <cmd name="href">
              <parm>mailto:<xsl:value-of select="contact[@type='work']/email"/></parm>
              <parm><xsl:value-of select="contact[@type='work']/email"/></parm>
            </cmd>
          <spec cat="esc"/><spec cat="esc"/>
          <spec cat="nl"/>
        </xsl:if>
      </env>
      <spec cat="nl"/>
      <cmd name="vspace" nl1="1" nl2="1"><parm>12pt</parm></cmd>
      <spec cat="nl"/>
      <cmd name="rule" nl1="1" nl2="1">
        <parm><cmd name="textwidth" gr="0"/></parm>
        <parm>1pt</parm>
      </cmd>

  </xsl:template>
  <xsl:template match="education">
    <cmd name="titlespacing">
      <parm><cmd name="section" gr="0"/></parm>
      <parm>0pt</parm>
      <parm><cmd name="baselineskip" gr="0"/></parm>
      <parm><cmd name="baselineskip" gr="0"/></parm>
      <parm></parm>
    </cmd>
    <cmd name="titleformat">
      <parm><cmd name="section" gr="0"/></parm>
      <opt>hang</opt>
      <parm><cmd name="Large" gr="0"/></parm>
      <parm></parm>
      <parm>1em</parm>
      <parm></parm>
      <opt></opt>
    </cmd>
    <cmd name="section*" nl2="1"><parm>Education</parm></cmd>
    <spec cat="nl"/>
    <!-- subsection formatting -->
    <cmd name="titlespacing">
      <parm><cmd name="subsection" gr="0"/></parm>
      <parm>10pt</parm>
      <parm><cmd name="baselineskip" gr="0"/></parm>
      <parm>0.5<cmd name="baselineskip" gr="0"/></parm>
      <parm></parm>
    </cmd>
    <cmd name="titleformat">
      <parm><cmd name="subsection" gr="0"/></parm>
      <opt>runin</opt>
      <parm><cmd name="bf" gr="0"/></parm>
      <parm></parm>
      <parm>0pt</parm>
      <parm></parm>
      <opt>,</opt>
    </cmd>
    <spec cat="nl"/>
    <xsl:for-each select="school">
      <cmd name="subsection*" nl2="1"><parm><xsl:value-of select="degree"/></parm></cmd>
      <xsl:value-of select="name"/>,<spec cat="space"/>
      <group>
        <xsl:if test="finish[@tbd='1']">
           <cmd name="it" gr="0"/>
           anticipated
           <spec cat="space"/>
        </xsl:if>
        <xsl:value-of select="finish"/>
      </group>
      <xsl:if test="gpa">
        <group>
          (
          <cmd name="it" gr="0"/>
          GPA:
          <spec cat="space"/>
          <xsl:value-of select="gpa"/>
          )
        </group>
      </xsl:if>
      <xsl:if test="note | thesis | committee">
        <env name="itemize">
          <xsl:for-each select="thesis">
            <cmd name="item" gr="0" nl1="1"/><spec cat="space"/>
            <xsl:if test="@type">
              <group>
                <cmd name="it" gr="0"/>
                <xsl:value-of select="@type"/>:<spec cat="nil"/>
              </group>
            </xsl:if>
            <xsl:value-of select="."/>
          </xsl:for-each>
          <xsl:for-each select="note">
            <cmd name="item" gr="0" nl1="1"/><spec cat="space"/>
            <xsl:value-of select="."/>
          </xsl:for-each>
          <xsl:for-each select="committee">
            <cmd name="item" gr="0" nl1="1"/><spec cat="space"/>
            <env name="tabbing">
              <cmd name="textit"><parm>Committee:</parm></cmd>
              <spec cat="space"/><spec cat="esc"/>=
              <xsl:value-of select="member"/>
              <xsl:for-each select="member[position()>1]">
                <spec cat="esc"/><spec cat="esc"/><spec cat="nl"/>
                <spec cat="esc"/><spec cat="gt"/>
                <xsl:value-of select="."/>
              </xsl:for-each>
            </env>
          </xsl:for-each>
        </env>
      </xsl:if>


    </xsl:for-each>
  </xsl:template>
  <xsl:template match="employment">
    <!-- subsection formatting -->
    <cmd name="titleformat">
      <parm><cmd name="subsection" gr="0"/></parm>
      <opt>runin</opt>
      <parm>
        <cmd name="large" gr="0"/>
        <cmd name="it" gr="0"/>
      </parm>
      <parm></parm>
      <parm>0pt</parm>
      <parm></parm>
      <opt><cmd name="hfill" gr="0"/><spec cat="esc"/><spec cat="space"/></opt>
    </cmd>

    <cmd name="section*" nl2="1">
      <parm>
        <xsl:if test="@type">
          <xsl:value-of select="@type"/>
        </xsl:if>
        <xsl:if test="not(@type)">
          Employment
        </xsl:if>
      </parm>
    </cmd>
    <spec cat="nl"/>
    <xsl:for-each select="job">
      <cmd name="subsection*"><parm><xsl:value-of select="company"/></parm></cmd>
      <xsl:if test="department">
        <xsl:value-of select="department"/>
        <cmd name="hfill" gr="0"/>
        <spec cat="space"/>
      </xsl:if>
      <xsl:value-of select="location"/>
      <env name="itemize">
        <xsl:for-each select="position">
          <cmd name="item" gr="0" nl1="1"/><spec cat="space"/>
          <xsl:value-of select="title"/>
          <xsl:for-each select="description">
            <env name="itemize">
              <cmd name="item" gr="0" nl1="1"/><spec cat="space"/>
              <xsl:value-of select="."/>
            </env>
          </xsl:for-each>
        </xsl:for-each>
      </env>
    </xsl:for-each>

  </xsl:template>
  <xsl:template match="awards">
    <cmd name="section*" nl2="1">
      <parm>Honors and Awards</parm>
    </cmd>
    <spec cat="nl"/>
    <xsl:for-each select="item">
      <cmd name="rowtabular" nl1="1" nl2="1">
        <opt>5.5in</opt>
        <parm><xsl:value-of select="."/></parm>
        <parm></parm>
        <parm></parm>
      </cmd>
    </xsl:for-each>

  </xsl:template>

  <xsl:template match="research">
    <cmd name="newenvironment">
      <parm>biblist</parm>
      <parm>
        <cmd name="begin">
          <parm>list</parm>
          <parm></parm>
          <parm>
            <cmd name="setlength">
              <parm><cmd name="leftmargin" gr="0"/></parm>
              <parm>50pt</parm>
            </cmd>
            <cmd name="setlength">
              <parm><cmd name="itemsep" gr="0"/></parm>
              <parm>0.2em</parm>
            </cmd>
            <cmd name="setlength">
              <parm><cmd name="parskip" gr="0"/></parm>
              <parm>0pt</parm>
            </cmd>
            <cmd name="setlength">
              <parm><cmd name="parsep" gr="0"/></parm>
              <parm>0.25em</parm>
            </cmd>
            <cmd name="setlength">
              <parm><cmd name="itemindent" gr="0"/></parm>
              <parm>-20pt</parm>
            </cmd>
          </parm>
        </cmd>
      </parm>
      <parm>
        <cmd name="end">
          <parm>list</parm>
        </cmd>
      </parm>
    </cmd>
    <cmd name="section*" nl2="1">
      <parm>Research</parm>
    </cmd>
    <spec cat="nl"/>
    <!-- article -->
    <xsl:if test="article">
      <cmd name="subsection*" nl2="1">
        <parm>Journal Articles</parm>
      </cmd>
      <env name="biblist">
        <xsl:for-each select="article">
          <cmd name="item" gr="0" nl1="1"/><spec cat="space"/>
          <!-- authors -->
          <xsl:if test="count(author)=1">
            <group>
              <xsl:if test="author[@self]">
                <cmd name="bf" gr="0"/><spec cat="space"/>
              </xsl:if>
              <xsl:value-of select="author"/>
            </group>
          </xsl:if>
          <xsl:if test="count(author)=2">
            <group>
              <xsl:if test="author[1][@self]">
                <cmd name="bf" gr="0"/><spec cat="space"/>
              </xsl:if>
              <xsl:value-of select="author[1]"/>
            </group>
            and
            <group>
              <xsl:if test="author[2][@self]">
                <cmd name="bf" gr="0"/><spec cat="space"/>
              </xsl:if>
              <xsl:value-of select="author[2]"/>
            </group>
          </xsl:if>
          <xsl:if test="count(author)>2">
            <xsl:for-each select="author[position()&lt;last()]">
              <group>
                <xsl:if test="@self">
                  <cmd name="bf" gr="0"/><spec cat="space"/>
                </xsl:if>
                <xsl:value-of select="."/>,
              </group>
            </xsl:for-each>
            and
            <group>
              <xsl:if test="author[last()][@self]">
                <cmd name="bf" gr="0"/><spec cat="space"/>
              </xsl:if>
              <xsl:value-of select="author[last()]"/>
            </group>
          </xsl:if>.
          <!-- end authors -->
          <TeXML ligatures="1">``</TeXML>
          <xsl:value-of select="title"/>.<spec cat="nil"/>
          <TeXML ligatures="1">''</TeXML>
          <spec cat="space"/>
          <cmd name="textit">
            <parm><xsl:value-of select="journal"/>.</parm>
          </cmd>
          <spec cat="space"/>
          <xsl:value-of select="volume"/>.<xsl:value-of select="issue"/>
          <spec cat="space"/>
          (<xsl:value-of select="date"/>)
          <spec cat="space"/>
          pp. <xsl:value-of select="pages"/>
        </xsl:for-each>
      </env>
    </xsl:if>

    <!-- proceedings -->
    <xsl:if test="proceedings">
      <cmd name="subsection*" nl2="1">
        <parm>Conference Proceedings</parm>
      </cmd>
      <env name="biblist">
        <xsl:for-each select="proceedings">
          <cmd name="item" gr="0" nl1="1"/><spec cat="space"/>
          <!-- authors -->
          <xsl:if test="count(author)=1">
            <group>
              <xsl:if test="author[@self]">
                <cmd name="bf" gr="0"/><spec cat="space"/>
              </xsl:if>
              <xsl:value-of select="author"/>
            </group>
          </xsl:if>
          <xsl:if test="count(author)=2">
            <group>
              <xsl:if test="author[1][@self]">
                <cmd name="bf" gr="0"/><spec cat="space"/>
              </xsl:if>
              <xsl:value-of select="author[1]"/>
            </group>
            and
            <group>
              <xsl:if test="author[2][@self]">
                <cmd name="bf" gr="0"/><spec cat="space"/>
              </xsl:if>
              <xsl:value-of select="author[2]"/>
            </group>
          </xsl:if>
          <xsl:if test="count(author)>2">
            <xsl:for-each select="author[position()&lt;last()]">
              <group>
                <xsl:if test="@self">
                  <cmd name="bf" gr="0"/><spec cat="space"/>
                </xsl:if>
                <xsl:value-of select="."/>,
              </group>
            </xsl:for-each>
            and
            <group>
              <xsl:if test="author[last()][@self]">
                <cmd name="bf" gr="0"/><spec cat="space"/>
              </xsl:if>
              <xsl:value-of select="author[last()]"/>
            </group>
          </xsl:if>.
          <!-- end authors -->
          <TeXML ligatures="1">``</TeXML>
          <xsl:value-of select="title"/>.<spec cat="nil"/>
          <TeXML ligatures="1">''</TeXML>
          <spec cat="space"/>
          <cmd name="textit">
            <parm><xsl:value-of select="journal"/>.</parm>
          </cmd>
          <spec cat="space"/>
          <xsl:value-of select="location"/>,
          <spec cat="space"/>
          <xsl:value-of select="date"/>
        </xsl:for-each>
      </env>
    </xsl:if>

    <!-- presentations -->
    <xsl:if test="presentation">
      <cmd name="subsection*" nl2="1">
        <parm>Presentations</parm>
      </cmd>
      <env name="itemize">
        <xsl:for-each select="presentation">
          <cmd name="item" gr="0" nl1="1"/><spec cat="space"/>
          <cmd name="textit">
            <parm><xsl:value-of select="title"/></parm>
          </cmd>
          <env name="itemize">
            <cmd name="item" gr="0" nl1="1"/><spec cat="space"/>
            <xsl:value-of select="event"/>,<spec cat="space"/>
            <xsl:value-of select="location"/>,<spec cat="space"/>
            <xsl:value-of select="date"/>,<spec cat="space"/>
          </env>
        </xsl:for-each>
      </env>
    </xsl:if>

  </xsl:template>

  <xsl:template match="activity">
    <cmd name="subsection*" nl2="1">
      <parm><xsl:value-of select="@type"/></parm>
    </cmd>
    <xsl:for-each select="item">
      <cmd name="rowtabular" nl2="1">
        <parm><xsl:value-of select="task"/></parm>
        <parm><xsl:value-of select="title | location"/></parm>
        <parm><xsl:value-of select="date"/></parm>
      </cmd> 
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="preamble">
      <cmd name="documentclass">
        <opt>10pt, letterpaper</opt>
        <parm>article</parm>
      </cmd>
      <cmd name="newcommand">
        <parm><cmd name="name" gr="0"/></parm>
        <parm><xsl:value-of select="profile/fullname"/></parm>
      </cmd>
      <TeXML escape="0" ligatures="1"><xsl:text>
%


\usepackage{geometry}
\usepackage{titlesec}
\usepackage{tabularx}

\usepackage{CJK}
\usepackage{pinyin}

\usepackage{lastpage}
\usepackage{fancyhdr}
\setlength{\headheight}{14.5pt}
\fancyhead{}
\fancyfoot{}
\fancyhead[L]{\emph{\name\ --- cirriculum vit\ae}}
\fancyhead[R]{\thepage/\pageref{LastPage}}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\fancypagestyle{plain}{
  \fancyhf{}
  \fancyfoot[C]{Updated: \today}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\usepackage{datetime}
\newdateformat{tbhdate}{\twodigit{\THEDAY}\ \monthname[\THEMONTH] \THEYEAR}
\tbhdate

\usepackage[firstinits=true,
            isbn=false,
            citestyle=numeric-comp,
            bibstyle=numeric,
            sorting=none,
            maxnames=10,
            backend=bibtex]{biblatex}
\addbibresource{cv.bib}

% Fonts
\usepackage[T1]{fontenc}
\usepackage[urw-garamond]{mathdesign}

\usepackage[plainpages=false]{hyperref}

\hypersetup{
  colorlinks = true,
  urlcolor = black,
  linkcolor = black,
  citecolor = black,
  filecolor = black,
  pdfauthor = {\name},
  pdfkeywords = {engineering mechanics},
  pdftitle = {\name: Curriculum vitae},
  pdfsubject = {curriculum vitae},
  pdfpagemode = UseNone
}

\geometry{
  body={6.5in, 9.0in},
  left=1.0in,
  top=1.0in
}

% Customize page headers
\pagestyle{fancy}
\thispagestyle{plain}

% Don't indent paragraphs.
\setlength\parindent{0em}
\renewcommand{\baselinestretch}{1.0}

% Make lists without bullets and compact spacing
\renewenvironment{itemize}{
  \begin{list}{}{
    \setlength{\leftmargin}{30pt}
    \setlength{\itemsep}{0.2em}
    \setlength{\parskip}{0pt}
    \setlength{\parsep}{0.25em}
  }
}{
  \end{list}
}

\newcommand{\rowtabular}[4][3.7in]{%
  \begin{tabularx}{\linewidth}{p{24pt} @{}p{#1} X r@{}}%
    &amp; #2 &amp; #3 &amp; #4 \\ [1.0pt]%
  \end{tabularx}%
}

\renewcommand{\textsuperscript}[1]{%
  \raisebox{2.5pt}{\scriptsize \hspace{0.3pt}#1}%
}
      </xsl:text></TeXML>

  </xsl:template>


<xsl:template name="tex_comment">
  <!-- tex_comment
       comment out a string (replace newlines with comments)
       parameters:
           text  : string to comment out in TeX document
       returns:
           text as a TeX comment
  -->
  <xsl:param name="text"/>
  <xsl:param name="newline" select="'&#10;'" />

  <TeXML escape="0">
    <xsl:value-of select="'% '"/>
    <xsl:call-template name="str_replace">
      <xsl:with-param name="pString" select="$text"/>
      <xsl:with-param name="pFind" select="$newline"/>
      <xsl:with-param name="pReplace" select="concat($newline,'% ')"/>
    </xsl:call-template>
    <xsl:value-of select="$newline"/>
  </TeXML>
 </xsl:template>

<xsl:template name="str_replace">
  <!-- str_replace
       parameters:
           pString  : string to work on
           pFind    : string to find
           pReplace : string to replace with
       returns:
           pString with pFind replaced by pReplace
  -->
  <xsl:param name="pString"/>
  <xsl:param name="pFind"/>
  <xsl:param name="pReplace"/>

  <xsl:if test="$pString">
    <xsl:value-of select="substring-before($pString,$pFind)"/>
    <xsl:value-of select="$pReplace"/>
    <xsl:call-template name="str_replace">
      <xsl:with-param name="pString" select="substring-after($pString,$pFind)"/>
      <xsl:with-param name="pFind" select="$pFind"/>
      <xsl:with-param name="pReplace" select="$pReplace"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>


</xsl:stylesheet>
