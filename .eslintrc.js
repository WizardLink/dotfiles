/**
 * ESLint configuration for work,
 * -- as I cannot plug ESLint on it.
 */

module.exports =
{
	env:
	{
		browser: true,
		es6: true,
		jquery: true,
	},
	extends:
	[
		'eslint:recommended',
	],
	globals:
	{
		kendo: "readonly"
	},
	parserOptions:
	{
		ecmaVersion: 6,
		sourceType: "module"
	},
	root: true,
	rules:
	{
		'brace-style':
		[
			'error',
			'allman',
			{
				'allowSingleLine': true
			},
		],
		'comma-dangle':
		[
			'error',
			'always-multiline'
		],
		'curly':
		[
			'error',
			'multi-line',
		],
		'indent':
		[
			'warn',
			'tab'
		],
		'quotes':
		[
			'error',
			'double',
		],
		'quote-props':
		[
			'error',
			'as-needed',
		],
		'semi':
		[
			'error',
			'always',
		],
		'no-trailing-spaces': 'error',
		'no-undef': 'off',
		'no-unexpected-multiline': 'off',
		'no-unused-vars': 'off',
		'radix': 'off',
		'require-atomic-updates': 'off',
	}
};
