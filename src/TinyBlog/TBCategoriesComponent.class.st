Class {
	#name : #TBCategoriesComponent,
	#superclass : #WAComponent,
	#instVars : [
		'categories',
		'postsList'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #'as yet unclassified' }
TBCategoriesComponent class >> categories: categories postsList: aTBScreen [
	^ self new 
		categories: categories; 
		postsList: aTBScreen; 
		yourself.
]

{ #category : #accessing }
TBCategoriesComponent >> categories [
	^ categories
]

{ #category : #accessing }
TBCategoriesComponent >> categories: aCollection [
	categories := aCollection asSortedCollection
]

{ #category : #accessing }
TBCategoriesComponent >> postsList [
	^ postsList
]

{ #category : #accessing }
TBCategoriesComponent >> postsList: aComponent [
	postsList := aComponent
]

{ #category : #rendering }
TBCategoriesComponent >> renderCategoryLinkOn: html with: aCategory [
	html listGroupLinkedItem
		class: 'active' if: aCategory = self postsList currentCategory;
		callback: [ self selectCategory: aCategory ];
		with: aCategory.
]

{ #category : #rendering }
TBCategoriesComponent >> renderContentOn: html [
	html listGroup: [ 
		html listGroupItem with: [ html strong: 'Categories' ].
		categories asSortedCollection do: [ :e | self renderCategoryLinkOn: html with: e ]
		]
]

{ #category : #rendering }
TBCategoriesComponent >> rendererClass [ 
   ^ SBSHtmlCanvas 
]

{ #category : #rendering }
TBCategoriesComponent >> selectCategory: aCategory [
	postsList currentCategory: aCategory
]
