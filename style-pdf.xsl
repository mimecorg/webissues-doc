<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/fo/docbook.xsl"/>

<xsl:param name="fop1.extensions" select="1"></xsl:param>

<xsl:param name="paper.type">A4</xsl:param>

<xsl:param name="body.start.indent">0pt</xsl:param>

<xsl:param name="generate.toc">
  book toc,title
</xsl:param>

<xsl:param name="body.font.family">DejaVuSerif</xsl:param>
<xsl:param name="title.font.family">DejaVuSans</xsl:param>
<xsl:param name="monospace.font.family">DejaVuSansMono</xsl:param>
<xsl:param name="dingbat.font.family"/>
<xsl:param name="symbol.font.family"/>

<xsl:param name="line-height">1.35</xsl:param>

<xsl:param name="body.font.master">9</xsl:param>

<xsl:attribute-set name="component.title.properties">
  <xsl:attribute name="font-size">16pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level1.properties">
  <xsl:attribute name="font-size">14pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level2.properties">
  <xsl:attribute name="font-size">12pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level3.properties">
  <xsl:attribute name="font-size">11pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level4.properties">
  <xsl:attribute name="font-size">10pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level5.properties">
  <xsl:attribute name="font-size">9pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level6.properties">
  <xsl:attribute name="font-size">9pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="formal.title.properties">
  <xsl:attribute name="font-weight">normal</xsl:attribute>
  <xsl:attribute name="font-size">9pt</xsl:attribute>
  <xsl:attribute name="space-before.minimum">0.2em</xsl:attribute>
  <xsl:attribute name="space-before.optimum">0.3em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">0.4em</xsl:attribute>
</xsl:attribute-set>

<xsl:param name="formal.title.placement">
  figure after
  example after
  table after
</xsl:param>

<xsl:attribute-set name="nongraphical.admonition.properties">
  <xsl:attribute name="border">0.5 pt solid black</xsl:attribute>
  <xsl:attribute name="padding">6pt</xsl:attribute>
  <xsl:attribute name="background-color">#eeeeee</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="admonition.title.properties">
  <xsl:attribute name="font-family"><xsl:value-of select="$title.fontset"/></xsl:attribute>
  <xsl:attribute name="font-size">12pt</xsl:attribute>
</xsl:attribute-set>

<xsl:template name="nongraphical.admonition">
  <xsl:param name="node" select="."/>
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>
  <xsl:variable name="bgcolor">
    <xsl:choose>
      <xsl:when test="local-name($node)='note'">#eeeeee</xsl:when>
      <xsl:when test="local-name($node)='warning'">#ffffcc</xsl:when>
      <xsl:when test="local-name($node)='tip'">#ddddff</xsl:when>
      <xsl:otherwise>#ffffff</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <fo:block id="{$id}"
            background-color="{$bgcolor}"
            xsl:use-attribute-sets="nongraphical.admonition.properties">
    <xsl:if test="$admon.textlabel != 0 or title or info/title">
      <fo:block keep-with-next.within-column='always'
                xsl:use-attribute-sets="admonition.title.properties">
        <xsl:apply-templates select="." mode="object.title.markup">
          <xsl:with-param name="allow-anchors" select="1"/>
        </xsl:apply-templates>
      </fo:block>
    </xsl:if>

    <fo:block xsl:use-attribute-sets="admonition.properties">
      <xsl:apply-templates/>
    </fo:block>
  </fo:block>
</xsl:template>

<xsl:param name="variablelist.as.blocks" select="1"/>

<xsl:template match="guilabel">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

<xsl:template match="guimenu">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

<xsl:template match="guimenuitem">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

<xsl:template match="guibutton">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

<xsl:template match="shortcut">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

<xsl:param name="header.column.widths">4 1 4</xsl:param>

<xsl:template name="header.content">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="position" select="''"/>
  <xsl:param name="gentext-key" select="''"/>
  <fo:block>
    <xsl:choose>
      <xsl:when test="$position='left' and $pageclass != 'titlepage'">
        <xsl:value-of select="//title[1]"/>
      </xsl:when>
      <xsl:when test="$position='right' and $pageclass != 'titlepage' and $pageclass != 'lot' and $sequence != 'first'">
        <xsl:apply-templates select="." mode="titleabbrev.markup"/>
      </xsl:when>
    </xsl:choose>
  </fo:block>
</xsl:template>

<xsl:template match="title" mode="book.titlepage.recto.auto.mode">
  <fo:block xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center" font-size="24pt" margin-top="150pt" font-weight="bold" font-family="{$title.fontset}">
    <xsl:call-template name="division.title">
      <xsl:with-param name="node" select="ancestor-or-self::book[1]"/>
    </xsl:call-template>
  </fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="book.titlepage.recto.auto.mode">
  <fo:block xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center" font-size="20pt" space-before="30pt" font-family="{$title.fontset}">
    <xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="author" mode="book.titlepage.recto.auto.mode">
  <fo:block xsl:use-attribute-sets="book.titlepage.recto.style" font-size="16pt" space-before="100pt" keep-with-next.within-column="always">
    <xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="author" mode="book.titlepage.verso.auto.mode">
  <fo:block xsl:use-attribute-sets="book.titlepage.verso.style" space-before="20pt">
    <xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="copyright" mode="book.titlepage.verso.auto.mode">
  <fo:block xsl:use-attribute-sets="book.titlepage.verso.style" space-before="10pt">
    <xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="legalnotice" mode="book.titlepage.verso.auto.mode">
  <fo:block xsl:use-attribute-sets="book.titlepage.verso.style" space-before="10pt" font-size="9pt">
    <xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
  </fo:block>
</xsl:template>

<xsl:template name="initial.page.number">auto</xsl:template>
<xsl:template name="page.number.format">1</xsl:template>

</xsl:stylesheet>
