<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/xhtml/chunk.xsl"/>

<xsl:param name="html.stylesheet">common/style.css</xsl:param>

<xsl:param name="make.clean.html" select="1"/>
<xsl:param name="docbook.css.source"></xsl:param>

<xsl:param name="logo.path">common/webissues.png</xsl:param>
<xsl:param name="logo.name">WebIssues</xsl:param>

<xsl:param name="use.id.as.filename" select="1"/>

<xsl:param name="chunk.first.sections" select="0"/>
<xsl:param name="chunk.section.depth" select="1"/>

<xsl:param name="chunker.output.indent" select="'yes'"/>

<xsl:param name="section.autolabel" select="0"/>

<xsl:param name="generate.toc">
  book toc,title
</xsl:param>

<xsl:param name="toc.section.depth" select="2"/>

<xsl:param name="formal.title.placement">
  figure after
  example after
  table after
</xsl:param>

<xsl:param name="formal.object.break.after" select="0"/>

<xsl:template name="chunk-element-content">
  <xsl:param name="prev"/>
  <xsl:param name="next"/>
  <xsl:param name="nav.context"/>
  <xsl:param name="content">
    <xsl:apply-imports/>
  </xsl:param>
  <xsl:variable name="home" select="/*[1]"/>
  <xsl:variable name="up" select="parent::*"/>
  <html>
    <xsl:call-template name="html.head">
      <xsl:with-param name="prev" select="$prev"/>
      <xsl:with-param name="next" select="$next"/>
    </xsl:call-template>
    <body>
      <xsl:call-template name="body.attributes"/>
      <div id="wrapper">
        <div id="header">
          <div id="header-top">
            <div id="header-left">
              <h1>
                <img src="{$logo.path}" alt="{$logo.name}" id="logo"/>
                <xsl:apply-templates select="$home" mode="title.markup"/>
              </h1>
            </div>
            <div id="header-right">
              <xsl:apply-templates select="/book/bookinfo/subtitle[1]" mode="titlepage.mode" />
            </div>
          </div>
          <div id="infobar">
            <div id="infobar-left">
              <a accesskey="h">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$home"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:call-template name="gentext.nav.home"/>
              </a>
              <xsl:if test="count($up) > 0 and $up != $home">
                <xsl:text disable-output-escaping="yes"> &amp;raquo; </xsl:text>
                <a accesskey="u">
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$up"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:apply-templates select="$up" mode="title.markup"/>
                </a>
              </xsl:if>
            </div>
            <div id="infobar-right">
            </div>
          </div>
        </div>
        <div id="body">
          <xsl:call-template name="common.navigation.links">
            <xsl:with-param name="prev" select="$prev"/>
            <xsl:with-param name="next" select="$next"/>
          </xsl:call-template>
          <xsl:copy-of select="$content"/>
          <xsl:call-template name="common.navigation.links">
            <xsl:with-param name="prev" select="$prev"/>
            <xsl:with-param name="next" select="$next"/>
          </xsl:call-template>
          <div id="footer">
            <xsl:apply-templates select="/book/bookinfo/copyright" mode="titlepage.mode"/>
          </div>
        </div>
      </div>
    </body>
  </html>
  <xsl:value-of select="$chunk.append"/>
</xsl:template>

<xsl:template name="common.navigation.links">
  <xsl:param name="prev" select="/foo"/>
  <xsl:param name="next" select="/foo"/>
  <div class="navlinks">
    <div class="navleft">
      <xsl:if test="count($prev) > 0">
        <xsl:text disable-output-escaping="yes">&amp;laquo; </xsl:text>
        <a accesskey="p">
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="object" select="$prev"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:apply-templates select="$prev" mode="title.markup"/>
        </a>
      </xsl:if>
    </div>
    <div class="navright">
      <xsl:if test="count($next) > 0">
        <a accesskey="n">
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="object" select="$next"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:apply-templates select="$next" mode="title.markup"/>
        </a>
        <xsl:text disable-output-escaping="yes"> &amp;raquo;</xsl:text>
      </xsl:if>
    </div>
  </div>
</xsl:template>

<xsl:template match="author" mode="titlepage.mode">
  <p class="{name(.)}">
    <xsl:call-template name="person.name"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="./affiliation" mode="titlepage.mode"/>
  </p>
</xsl:template>

<xsl:template match="affiliation" mode="titlepage.mode">
    <xsl:apply-templates select="./address/email" mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="email">
  <xsl:text>(</xsl:text>
  <span>
    <xsl:value-of select="substring-before(.,'@')"/>
  </span>
  <xsl:text> at </xsl:text>
  <span>
    <xsl:value-of select="substring-after(.,'@')"/>
  </span>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template name="toc.line">
  <xsl:param name="toc-context" select="."/>
  <xsl:param name="depth" select="1"/>
  <xsl:param name="depth.from.context" select="8"/>
  <span>
    <xsl:attribute name="class"><xsl:value-of select="local-name(.)"/></xsl:attribute>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target">
          <xsl:with-param name="context" select="$toc-context"/>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:variable name="label">
        <xsl:apply-templates select="." mode="label.markup"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="self::chapter">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">Chapter</xsl:with-param>
          </xsl:call-template>
          <xsl:text>&#160;</xsl:text>
        </xsl:when>
        <xsl:when test="self::appendix">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">Appendix</xsl:with-param>
          </xsl:call-template>
          <xsl:text>&#160;</xsl:text>
        </xsl:when>
      </xsl:choose>
      <xsl:copy-of select="$label"/>
      <xsl:if test="$label != ''">
        <xsl:value-of select="$autotoc.label.separator"/>
      </xsl:if>
      <xsl:apply-templates select="." mode="titleabbrev.markup"/>
    </a>
  </span>
</xsl:template>

</xsl:stylesheet>
