"
I am a stack using a OrderedCollection under the hood.

I store the top of the stack at the bottom of the collection as it is more efficient.
"
Class {
	#name : #PureOrderedCollectionStackStrategy,
	#superclass : #PureAbstractStackStrategy,
	#instVars : [
		'orderedCollection'
	],
	#category : #'PureCollections-Stack-Strategies'
}

{ #category : #enumerating }
PureOrderedCollectionStackStrategy >> do: aBlock [
	orderedCollection reverseDo: aBlock
]

{ #category : #initialization }
PureOrderedCollectionStackStrategy >> initialize [
	super initialize.
	self reset
]

{ #category : #removing }
PureOrderedCollectionStackStrategy >> pop [
 	^ orderedCollection removeLast
]

{ #category : #adding }
PureOrderedCollectionStackStrategy >> push: newObject [
 	orderedCollection addLast: newObject.
 	^ newObject
]

{ #category : #initialization }
PureOrderedCollectionStackStrategy >> reset [
	orderedCollection := OrderedCollection new
]

{ #category : #accessing }
PureOrderedCollectionStackStrategy >> size [
 	^ orderedCollection size
]

{ #category : #accessing }
PureOrderedCollectionStackStrategy >> top [
 	^ orderedCollection last
]
