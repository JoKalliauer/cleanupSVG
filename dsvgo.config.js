'use strict'

const { extendDefaultPlugins } = require('svgo')

module.exports = {
  multipass: true,
  js2svg: {
    pretty: true,
    indent: 2
  },
  plugins: extendDefaultPlugins([
    {
      name: 'cleanupAttrs',
      active: false
    },
    {
      name: 'cleanupEnableBackground',
      active: false
    },
    {
      name: 'cleanupIDs',
      active: false
    },
    {
      name: 'cleanupListOfValues',
      active: false
    },
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
      active: false
    },
    {
      name: 'convertPathData',
      active: false,
      params: {
        noSpaceAfterFlags: false
      }
    },
    {
      name: 'convertShapeToPath',
      active: false
    },
    {
      name: 'convertStyleToAttrs',
      active: false
    },
    {
      name: 'convertTransform',
      active: false
    },
    {
      name: 'inlineStyles',
      active: false
    },
    {
      name: 'mergePaths',
      active: false,
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
      active: false
    },
    {
      name: 'moveGroupAttrsToElems',
      active: false
    },
    {
      name: 'removeAttrs',
      active: false,
      params: {
        attrs: [
          'data-name',
          'fill',
          'clip-rule'
        ]
      }
    },
    {
      name: 'removeComments',
      active: false
    },
    {
      name: 'removeDesc',
      active: false
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
      name: 'removeEmptyAttrs',
      active: false
    },
    {
      name: 'removeEmptyContainers',
      active: false
    },
    {
      name: 'removeEmptyText',
      active: false
    },
    {
      name: 'removeHiddenElems',
      active: false
    },
    {
      name: 'removeMetadata',
      active: false
    },
    {
      name: 'removeNonInheritableGroupAttrs',
      active: false
    },
    {
      name: 'removeTitle',
      active: false
    },
    {
      name: 'removeUnknownsAndDefaults',
      params: {
        keepRoleAttr: true
      }
    },
    {
      name: 'removeUnusedNS',
      active: false
    },
    {
      name: 'removeUselessDefs',
      active: false
    },
    {
      name: 'removeUselessStrokeAndFill',
      active: false
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
      name: 'sortAttrs',
      active: false
    }
  ])
}
