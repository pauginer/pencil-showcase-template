<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:p="http://www.evolus.vn/Namespace/Pencil"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml">
<xsl:output method="html"/>

    <xsl:template match="/">
        <html>
            <head>
            	<meta name="viewport" content="width=device-width, initial-scale=1"/>
                <title>
                    <xsl:value-of select="/p:Document/p:Properties/p:Property[@name='fileName']/text()"/>
                </title>
                <script type="text/javascript" src="Resources/Script.js">
                    //
                </script>
            </head>
            <body>
                <div id="page">
                    <div id="content">
                        <xsl:apply-templates select="/p:Document/p:Pages/p:Page" />
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="p:Page">

        <div class="Page" id="{p:Properties/p:Property[@name='fid']/text()}_page">
            <div class="Image">
                <img src="{@rasterized}" width="{p:Properties/p:Property[@name='width']/text()}" height="{p:Properties/p:Property[@name='height']/text()}" usemap="#map_{p:Properties/p:Property[@name='fid']/text()}" id="{p:Properties/p:Property[@name='fid']/text()}_page_image"/>
                <div class="ImageFooter">&#160;</div>
                <xsl:if test="p:Links/p:Link">
                    <map name="map_{p:Properties/p:Property[@name='fid']/text()}">
                        <xsl:apply-templates select="p:Links/p:Link" />
                    </map>
                </xsl:if>
            </div>
        </div>

    </xsl:template>
    <xsl:template match="p:Link">
        <area shape="rect"
            coords="{@x},{@y},{@x+@w},{@y+@h}" href="#{@targetFid}_page"/>
    </xsl:template>
    
    <xsl:template match="html:*" mode="processing-notes">
        <xsl:copy>
            <xsl:copy-of select="@*[local-name() != '_moz_dirty']"/>
            <xsl:apply-templates mode="processing-notes"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="html:a[@page-fid]" mode="processing-notes">
        <a href="#{@page-fid}_page" title="Go tp page '{@page-name}'">
            <xsl:copy-of select="@class|@style"/>
            <xsl:apply-templates mode="processing-notes"/>
        </a>
    </xsl:template>
</xsl:stylesheet>
