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
    {
      name: 'cleanupIds',
      active: true
    },
/*    {
      name: 'cleanupListOfValues',//https://github.com/svg/svgo/issues/1402
    },*/
    {
      name: 'cleanupNumericValues',
      active: true
    },
    {
      name: 'collapseGroups',
      active: true
    },
    {
      name: 'convertColors',
      active: true
    },
    {
      name: 'convertPathData',
      active: true,
      params: {
        noSpaceAfterFlags: false
      }
    },
    {
      name: 'convertShapeToPath', //https://github.com/svg/svgo/issues/1466
      active: true
    },
    {
      name: 'convertStyleToAttrs', // https://github.com/svg/svgo/issues/1509
      active: false
    },
    {
      name: 'convertTransform',
      active: true
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
      active: true
    },
    {
      name: 'moveElemsAttrsToGroup',
      active: true
    },
    {
      name: 'moveGroupAttrsToElems',
      active: true
    },
    {
      name: 'removeAttrs',
      active: true,
    },
    {
      name: 'removeComments',
      active: true
    },
    {
      name: 'removeDesc',
      active: true
    },
	{
      name: 'removeDimensions',
      active: true //changes scaling of image
    },
    {
      name: 'removeDoctype',
      active: false
    },
    {
      name: 'removeEditorsNSData',
      active: true
    },
    {
      name: 'removeEmptyAttrs',
      active: true
    },
    {
      name: 'removeEmptyContainers',
      active: true
    },
    {
      name: 'removeEmptyText',
      active: true
    },
    {
      name: 'removeHiddenElems',
      active: true
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
      name: 'removeTitle',
      active: true
    },
    {
      name: 'removeUnknownsAndDefaults',
      active: true,
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
      active: true
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
      name: 'sortAttrs',
      active: true
    }
  ])
}
