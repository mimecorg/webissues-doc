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

<xsl:attribute-set name="component.title.properties">
  <xsl:attribute name="font-size">18pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level1.properties">
  <xsl:attribute name="font-size">16pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level2.properties">
  <xsl:attribute name="font-size">14pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level3.properties">
  <xsl:attribute name="font-size">12pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level4.properties">
  <xsl:attribute name="font-size">11pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level5.properties">
  <xsl:attribute name="font-size">10pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.title.level6.properties">
  <xsl:attribute name="font-size">10pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="formal.title.properties">
  <xsl:attribute name="font-weight">normal</xsl:attribute>
  <xsl:attribute name="font-size">10pt</xsl:attribute>
  <xsl:attribute name="space-before.minimum">0.2em</xsl:attribute>
  <xsl:attribute name="space-before.optimum">0.3em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">0.4em</xsl:attribute>
</xsl:attribute-set>

<xsl:param name="formal.title.placement">
  figure after
  example after
  table after
</xsl:param>

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

</xsl:stylesheet>
