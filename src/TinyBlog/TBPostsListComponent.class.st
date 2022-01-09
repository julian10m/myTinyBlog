Class {
	#name : #TBPostsListComponent,
	#superclass : #TBScreenComponent,
	#instVars : [
		'currentCategory',
		'postComponents'
	],
	#category : #TinyBlog
}

{ #category : #rendering }
TBPostsListComponent >> categoriesComponent [
	^ TBCategoriesComponent 
		categories: self blog allCategories 
		postsList: self
]

{ #category : #rendering }
TBPostsListComponent >> children [
	^ self postComponents, super children
]

{ #category : #accessing }
TBPostsListComponent >> currentCategory [
	^ currentCategory 
]

{ #category : #computing }
TBPostsListComponent >> currentCategory: anObject [
	currentCategory := anObject
]

{ #category : #rendering }
TBPostsListComponent >> goToAdminView [
	self call: TBAdminComponent new
]

{ #category : #private }
TBPostsListComponent >> initialize [ 
	super initialize.
	postComponents := OrderedCollection new.
]

{ #category : #accessing }
TBPostsListComponent >> postComponents [ 
	postComponents  := self readSelectedPosts collect: [ :e | TBPostComponent post: e ].
	^ postComponents 
]

{ #category : #computing }
TBPostsListComponent >> readSelectedPosts [
	^ self currentCategory 
		ifNil: [ self blog allVisibleBlogPosts ]
		ifNotNil: [ self blog allVisibleBlogPostsFromCategory: self currentCategory ]
]

{ #category : #rendering }
TBPostsListComponent >> renderCategoryColumnOn: html [
	html column
		extraSmallSize: 12;
		smallSize: 2;
		mediumSize: 4;
		with: [ html render: self categoriesComponent ]
]

{ #category : #rendering }
TBPostsListComponent >> renderContentOn: html [
	super renderContentOn: html.
	html container: [
		html row with: [ 
			self renderCategoryColumnOn: html.
			self renderPostsColumnOn: html ] 
		]
]

{ #category : #rendering }
TBPostsListComponent >> renderPostsColumnOn: html [
	html column
		extraSmallSize: 12;
		smallSize: 10;
		mediumSize: 8;
		with: [ self postComponents do: [ :c | html render: c ] ]
]
