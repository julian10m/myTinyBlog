Class {
	#name : #TBHeaderComponent,
	#superclass : #WAComponent,
	#instVars : [
		'component'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #'instance creation' }
TBHeaderComponent class >> from: aComponent [
	^ self new 
		component: aComponent; 
		yourself
]

{ #category : #accessing }
TBHeaderComponent >> component [
	^ component
]

{ #category : #accessing }
TBHeaderComponent >> component: anObject [
	component := anObject
]

{ #category : #rendering }
TBHeaderComponent >> renderBrandOn: html [
	html navigationBarBrand
		with:  [ 
			html 
				url: self application url;
				with: 'TinyBlog'
			 ].
]

{ #category : #rendering }
TBHeaderComponent >> renderButtonsOn: html [
	self renderSimpleAdminButtonOn: html
]

{ #category : #rendering }
TBHeaderComponent >> renderContentOn: html [
	| bar |
	bar := html navigationBar.
	bar beLight; expandLarge.
	bar background beLight.
	bar with: [ 
		html navigationBarBrand url: self application url; with: 'TinyBlog'.
		self renderButtonsOn: html] 

	"| bar id|
	id := 'navbar1'.
  	bar := html navigationBar.
   bar beLight; expandLarge.
   bar background beLight.
   bar with: [ 
		html navigationBarBrand: 'TinyBlog'.
		html
			navigationBarToggler
         beButtonType;
         collapse;
         dataTarget: id;
         with: [ html navigationBarTogglerIcon ].
]"
]

{ #category : #rendering }
TBHeaderComponent >> renderSimpleAdminButtonOn: html [
	html form: [
		html formButton bePrimary;
			callback: [ component goToAdminView ];
			with: [ html badge beLight with: 'Admin View' ]
			]
]

{ #category : #rendering }
TBHeaderComponent >> rendererClass [ 
   ^ SBSHtmlCanvas 
]
