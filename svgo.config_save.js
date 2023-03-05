'use strict'

// const { extendDefaultPlugins } = require('svgo')

module.exports = {
  multipass: true,
  js2svg: {
    pretty: true,
    indent: 1
  },
  plugins: ([
    {
      name: 'cleanupAttrs',
      active: true
    },
    {
      name: 'cleanupEnableBackground',
      active: true
    },
/*    {
      name: 'cleanupIDs',
      active: true
    },*/
/*    {
      name: 'cleanupListOfValues',//https://github.com/svg/svgo/issues/1402
    },*/
    {
      name: 'cleanupNumericValues',
      active: false
    },
    {
      name: 'collapseGroups',
      active: false
    },
    {
      name: 'convertColors',
      active: true
    },
    {
      name: 'convertPathData',
      active: false,
      params: {
        noSpaceAfterFlags: false
      }
    },
    {
      name: 'convertShapeToPath', //https://github.com/svg/svgo/issues/1466
      active: false
    },
    {
      name: 'convertStyleToAttrs', // https://github.com/svg/svgo/issues/1509
      active: false
    },
    {
      name: 'convertTransform',
      active: false
    },
    {
      name: 'inlineStyles', //keep CSS
      active: false
    },
    {
      name: 'mergePaths',
      active: true,
      params: {
        noSpaceAfterFlags: false
      }
    },
    {
      name: 'minifyStyles',
      active: false
    },
    {
      name: 'moveElemsAttrsToGroup',
      active: true
    },
    {
      name: 'moveGroupAttrsToElems',
      active: true
    },
/*    {
      name: 'removeAttrs',
      active: false
    },*/
    {
      name: 'removeComments',
      active: false
    },
    {
      name: 'removeDesc',
      active: false
    },
    {
      name: 'removeDimensions',
      active: false //changes scaling of image
    },
    {
      name: 'removeDoctype',
      active: false
    },
    {
      name: 'removeEditorsNSData',
      active: false
    },
    {
      name: 'removeElementsByAttr',
      active: false
    },
    {
      name: 'removeEmptyAttrs',
      active: true
    },
    {
      name: 'removeEmptyContainers', //https://github.com/svg/svgo/issues/1194 https://github.com/svg/svgo/issues/1618
      active: false
    },
    {
      name: 'removeEmptyText',
      active: true
    },
    {
      name: 'removeHiddenElems',
      active: false // https://commons.wikimedia.org/wiki/Help:SVG_guidelines#Invalid_elements_that_should_be_kept
    },
    {
      name: 'removeMetadata', //keep rdf-data
      active: false
    },
    {
      name: 'removeNonInheritableGroupAttrs',
      active: true
    },
    {
      name: 'removeOffCanvasPaths',
      active: false
    },
    {
      name: 'removeStyleElement',
      active: false
    },
    {
      name: 'removeTitle',
      active: false
    },
    {
      name: 'removeUnknownsAndDefaults',
      active: false, // https://commons.wikimedia.org/wiki/Help:SVG_guidelines#Invalid_elements_that_should_be_replaced
      params: {
        keepRoleAttr: true
      }
    },
    {
      name: 'removeUnusedNS',
      active: true
    },
    {
      name: 'removeUselessDefs',
      active: true
    },
    {
      name: 'removeUselessStrokeAndFill',
      active: true
    },
    {
      name: 'removeViewBox', 
      active: false
    },
    {
      name: 'removeXMLNS',
      active: false
    },
    {
      name: 'removeXMLProcInst',
      active: false
    },
    {
      name: 'reusePaths',
      active: false
    },
    {
      name: 'sortAttrs',
      active: true
    }
  ])
}
