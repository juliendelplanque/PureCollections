"
I am a stack using a LinkedList under the hood.

The first link of the linked list is considered as the top of the stack as it is efficient to add / remove.
"
Class {
	#name : #PureLinkedListStackStrategy,
	#superclass : #PureAbstractStackStrategy,
	#instVars : [
		'linkedList'
	],
	#category : #'PureCollections-Stack-Strategies'
}

{ #category : #enumerating }
PureLinkedListStackStrategy >> do: aBlock [
 	linkedList do: aBlock
]

{ #category : #initialization }
PureLinkedListStackStrategy >> initialize [
	super initialize.
	self reset
]

{ #category : #removing }
PureLinkedListStackStrategy >> pop [
 	"We use the first link of the linked list as the top of the stack as it is efficient to add / remove."
 	^ linkedList removeFirst
]

{ #category : #removing }
PureLinkedListStackStrategy >> push: newObject [
 	linkedList addFirst: newObject.
 	^ newObject
]

{ #category : #initialization }
PureLinkedListStackStrategy >> reset [
	linkedList := LinkedList new
]

{ #category : #accessing }
PureLinkedListStackStrategy >> size [
 	^ linkedList size
]

{ #category : #accessing }
PureLinkedListStackStrategy >> top [
 	^ linkedList first
]
