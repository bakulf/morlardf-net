<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" />

  <xsl:template match="section">
    <xsl:if test="title">
      <div id="sectitle"><xsl:value-of select="title"/></div>
    </xsl:if>

    <xsl:apply-templates select="p|list|image|table"/>
    <br/><br/>
  </xsl:template>

  <xsl:template match="link">
    <xsl:choose>
      <xsl:when test="@internal">
        <a href="{@internal}"><xsl:value-of select="."/></a>
      </xsl:when>
      <xsl:otherwise>
        <a href="{@external}"><xsl:value-of select="."/></a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="cmd">
    <pre><xsl:value-of select="."/></pre>
  </xsl:template>

  <xsl:template match="p">
    <br/>
    <xsl:for-each select="text()|link|cmd|b|i">
      <xsl:choose>
        <xsl:when test="node()">
          <xsl:apply-templates select="."/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <br/>
  </xsl:template>

  <xsl:template match="s">
    <xsl:for-each select="text()|link|b|i">
      <xsl:choose>
        <xsl:when test="node()">
          <xsl:apply-templates select="."/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <br/>
  </xsl:template>

  <xsl:template match="b">
    <b><xsl:value-of select="."/></b>
  </xsl:template>

  <xsl:template match="i">
    <i><xsl:value-of select="."/></i>
  </xsl:template>

  <xsl:template match="item">
    <li><xsl:apply-templates select="s"/><br/></li>
  </xsl:template>

  <xsl:template match="image">
    <br/><a href="{@file}">
      <xsl:choose>
        <xsl:when test="@resize = &quot;true&quot;">
            <img src="{@file}" alt="{.}" width="100%"/>
        </xsl:when>
        <xsl:when test="@thumbnail = &quot;true&quot;">
          <img src="{@file}" alt="{.}" width="200" height="200"/>
        </xsl:when>
        <xsl:otherwise>
          <img src="{@file}" alt="{.}"/>
        </xsl:otherwise>
      </xsl:choose>
    </a><br/>
  </xsl:template>

  <xsl:template match="list">
    <ul>
      <xsl:apply-templates select="item"/>
    </ul>
  </xsl:template>

  <xsl:template match="col">
    <td><xsl:apply-templates select="link|p|s|list|image|table"/></td>
  </xsl:template>

  <xsl:template match="col_title">
    <td><b><xsl:apply-templates select="link|p|s|list|image|table"/></b></td>
  </xsl:template>

  <xsl:template match="row">
    <tr>
      <xsl:apply-templates select="col|col_title"/>
    </tr>
  </xsl:template>

  <xsl:template match="table">
    <table>
      <xsl:apply-templates select="row"/>
    </table>
  </xsl:template>

  <xsl:template match="morla">
    <html>
      <head>
        <title><xsl:value-of select="/morla/title"/></title>
        <link rel="icon" href="../public/icons/64_color.png" type="image/ico" />
        <link rel="SHORTCUT ICON" href="../public/icons/64_color.png" />
        <link rel="stylesheet" type="text/css" href="../public/css/base.css" />
        <link rel="meta" href="../public/doap.rdf" />
      
        <meta name="author" content="Andrea Marchesini" />
      
        <meta name="description" content="Andrea Marchesini - bakunin homepage" />
        <meta content="text/html; charset=utf-8" http-equiv="content-type" />
      </head>

      <body>
        <div class="top">
          <h1>morla</h1>
        </div>
  
        <div id="left">
          <div id="menu">
            <ul class="sub">
              <li class="item_first"><a href="index.xml">documentation</a></li>
              <li><a href="..">return</a></li>
	    </ul>
	  </div>

          <img src="../public/images/morla.png" alt="morla's logo" />
	</div>

        <div class="content">
          <h2><xsl:value-of select="/morla/title"/></h2>
          <h2><xsl:value-of select="/morla/subtitle"/></h2>
          <xsl:apply-templates select="/morla/section"/>
        </div>
      
        <div id="footer">
          <a href="http://www.autistici.org/bakunin"><xsl:value-of select="/morla/copyright/author"/></a><br/>
          <xsl:value-of select="/morla/copyright/licence"/>
        </div>

      </body>
    </html>

  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="/morla"/>
  </xsl:template>

</xsl:stylesheet>
