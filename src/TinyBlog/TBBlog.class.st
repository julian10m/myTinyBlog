Class {
	#name : #TBBlog,
	#superclass : #Object,
	#instVars : [
		'posts'
	],
	#category : #TinyBlog
}

{ #category : #initialization }
TBBlog class >> createDemoPosts [
self current
writeBlogPost: ((TBPost title: 'Welcome in TinyBlog' text:
'TinyBlog is a small blog engine made with Pharo.' category:
'TinyBlog') visible: true);
writeBlogPost: ((TBPost title: 'Report Pharo Sprint' text:
'Friday, June 12 there was a Pharo sprint / Moose dojo. It was a
nice event with more than 15 motivated sprinters. With the help
of candies, cakes and chocolate, huge work has been done'
category: 'Pharo') visible: true);
writeBlogPost: ((TBPost title: 'Brick on top of Bloc -
Preview' text: 'We are happy to announce the first preview
version of Brick, a new widget set created from scratch on top
of Bloc. Brick is being developed primarily by Alex Syrel
(together with Alain Plantec, Andrei Chis and myself), and the
work is sponsored by ESUG.
Brick is part of the Glamorous Toolkit effort and will provide
the basis for the new versions of the development tools.'
category: 'Pharo') visible: true);
writeBlogPost: ((TBPost title: 'The sad story of unclassified
blog posts' text: 'So sad that I can read this.') visible: true);
writeBlogPost: ((TBPost title: 'Working with Pharo on the
Raspberry Pi' text: 'Hardware is getting cheaper and many new
small devices like the famous Raspberry Pi provide new
computation power that was one once only available on regular
desktop computers.' category: 'Pharo') visible: true)

]

{ #category : #initialization }
TBBlog class >> current [ 
	^ self selectAll 
		ifNotEmpty: [ :e | e anyOne  ] 
		ifEmpty: [ self new save ]
]

{ #category : #initialization }
TBBlog class >> initialize [ 
	self reset 
]

{ #category : #initialization }
TBBlog class >> initializeVoyageOnMemoryDB [
	VOMemoryRepository new enableSingleton 
]

{ #category : #initialization }
TBBlog class >> isVoyageRoot [ 
	^ true
]

{ #category : #initialization }
TBBlog class >> reset [
	self initializeVoyageOnMemoryDB 
]

{ #category : #accessing }
TBBlog >> allBlogPosts [
	^ posts
]

{ #category : #computing }
TBBlog >> allBlogPostsFromCategory: aString [ 
	^ posts select: [ :e | e category = aString ]
]

{ #category : #computing }
TBBlog >> allCategories [
	^ (self allBlogPosts collect: [ :e | e category ]) asSet
]

{ #category : #'accessing - arguments' }
TBBlog >> allVisibleBlogPosts [
	^ posts select: [ :e | e isVisible ]
]

{ #category : #computing }
TBBlog >> allVisibleBlogPostsFromCategory: aString [ 
	^ (self allBlogPostsFromCategory: aString) select: [ :e | e isVisible ]
]

{ #category : #computing }
TBBlog >> categoriesWithVisiblePosts [
	^ (self allVisibleBlogPosts collect: [ :e | e category ]) asSet
]

{ #category : #actions }
TBBlog >> deletePostsForCategory: aString [ 
	posts := self allBlogPosts reject: [ :e | e category = aString ].
	self save.
	
]

{ #category : #actions }
TBBlog >> displayCategory: aString [ 
	(self allBlogPostsFromCategory: aString) do: [ :e | e beVisible ].
	self save
]

{ #category : #actions }
TBBlog >> hideCategory: aString [ 
	(self allBlogPostsFromCategory: aString) do: [ :e | e notVisible ].
	self save
]

{ #category : #initialization }
TBBlog >> initialize [ 
	super initialize.
	posts := OrderedCollection new.
]

{ #category : #action }
TBBlog >> removeAllPosts [
	posts := OrderedCollection new.
	self save.
]

{ #category : #actions }
TBBlog >> renameCategory: aString toBe: aString2 [ 
	(self allBlogPostsFromCategory: aString) do: [ :e | e category: aString2 ].
	self save
]

{ #category : #actions }
TBBlog >> size [
	^ self allBlogPosts size
]

{ #category : #actions }
TBBlog >> writeBlogPost: aPost [ 
	self allBlogPosts add: aPost.
	self save
]
