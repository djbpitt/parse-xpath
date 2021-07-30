<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:djb="http://www.obdurodon.org" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xmlns:p="xpath3.1_parser" version="3.0">
    <xsl:output method="xml" indent="no"/>
    <xsl:import href="xpath31.xslt"/>
    <xsl:variable name="inputs" as="element(input)+">
        <input xmlns="">for $stuff in /TEI/text/body/descendant::div//tei:sp[@this = 'that' and
            count(preceding-sibling::other) eq 3] return if (true()) then distinct-values($stuff)
            else 'nope'</input>
    </xsl:variable>
    <xsl:template name="xsl:initial-template">
        <!-- ============================================================ -->
        <!-- Save XML version of parse                                    -->
        <!-- ============================================================ -->
        <xsl:result-document method="xml" indent="yes" href="xpath-parser-test-output.xml">
            <root xmlns="">
                <xsl:for-each select="$inputs">
                    <xsl:sequence select="p:parse-XPath(.)"/>
                </xsl:for-each>
            </root>
        </xsl:result-document>
        <!-- ============================================================ -->
        <!-- Create HTML output with syntax highlighting                  -->
        <!-- ============================================================ -->
        <html>
            <head>
                <title>XPath styling examples</title>
                <style type="text/css">
                    <!-- Colors based on <oXygen/> defaults -->
                    .PathExpr,
                    .Predicate,
                    .Punctuation {
                        color: black;
                    }
                    .StepExpr {
                        color: #0000E6;
                    }
                    .ValueComp,
                    .GeneralComp,
                    .AndExpr,
                    .OrExpr {
                        color: #787800;
                    }
                    .FunctionEQName {
                        color: #004000;
                        font-style: italic;
                    }
                    .StringLiteral,
                    .NumericLiteral {
                        color: #323296;
                    }
                    .AbbrevForwardStep {
                        color: #F08246;
                    }
                    .ForwardAxis,
                    .ReverseAxis {
                        color: #009696
                    }
                    .VarRef,
                    .SimpleForBinding {
                        color: #963296;
                    }
                    .Keyword {
                        color: #0096C8;
                    }</style>
            </head>
            <body>
                <h1>XPath styling examples</h1>
                <xsl:for-each select="$inputs">
                    <p>
                        <code>
                            <xsl:value-of select="."/>
                        </code>
                        <br/>
                        <xsl:apply-templates select="p:parse-XPath(.)" mode="style-xpath"/>
                    </p>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
    <!-- ================================================================ -->
    <!-- mode: style-xpath                                                -->
    <!-- ================================================================ -->
    <xsl:mode name="style-xpath" on-no-match="text-only-copy"/>
    <xsl:template match="XPath" mode="style-xpath">
        <code>
            <xsl:apply-templates mode="#current"/>
        </code>
    </xsl:template>
    <xsl:template match="
            StepExpr
            | AbbrevForwardStep[node()[1][self::TOKEN][. eq '@']]
            | AndExpr
            | ForwardAxis
            | FunctionEQName
            | GeneralComp
            | NumericLiteral
            | OrExpr
            | PathExpr
            | Predicate
            | ReverseAxis
            | StringLiteral
            | ValueComp
            | VarRef
            " mode="style-xpath">
        <span class="{local-name()}">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    <xsl:template match="SimpleForBinding/TOKEN | SimpleForBinding/VarName" mode="style-xpath">
        <span class="SimpleForBinding">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    <xsl:template match="
            SimpleForClause/TOKEN[. eq 'for']
            | ForExpr/TOKEN[. eq 'return']
            | IfExpr/TOKEN[. = ('if', 'then', 'else')]
            " mode="style-xpath">
        <span class="Keyword">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    <xsl:template match="FunctionCall/ArgumentList/TOKEN" mode="style-xpath">
        <span class="Punctuation">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
</xsl:stylesheet>
