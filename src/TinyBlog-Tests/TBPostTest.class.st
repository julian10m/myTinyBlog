Class {
	#name : #TBPostTest,
	#superclass : #TestCase,
	#category : #'TinyBlog-Tests'
}

{ #category : #tests }
TBPostTest >> testPostIsCreatedCorrectly [
	| post |
	post := TBPost 
		title: 'Welcome to TinyBlog' 
		text: 'TinyBlog is a small blog engine made with Pharo'
		category: 'TinyBlog'.
	self 
		assert: post title equals: 'Welcome to TinyBlog';
		assert: post category equals: 'TinyBlog'.
		 
]

{ #category : #tests }
TBPostTest >> testWithoutCategoryIsUnclassified [
	| post |
	post := TBPost 
		title: 'Welcome to TinyBlog' 
		text: 'TinyBlog is a small blog engine made with Pharo'.
	self 
		assert: post title equals: 'Welcome to TinyBlog';
		assert: post isUnclassified;
		deny: post isVisible.
		 
]
