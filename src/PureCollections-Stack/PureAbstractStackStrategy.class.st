"
I am an abstract stack strategy. My subclasses can be used as Stack internal implementation.

I define the common API to be understood by stack strategies:
 - #push: to push an object at the top of the stack.
 - #top to get the object at the top of the stack without removing it.
 - #pop to remove the object at the top of the stack and return it.
 - #do: to iterate on stack elements from top to bottom.
 - #size to get the size of the stack.
"
Class {
	#name : #PureAbstractStackStrategy,
	#superclass : #Object,
	#category : #'PureCollections-Stack-Strategies'
}

{ #category : #enumerating }
PureAbstractStackStrategy >> do: aBlock [
 	"Evaluate aBlock with each of the receiver's elements as the argument.
 	 Starts by the element at the top of the stackt and goes to the deepest element."

  	self subclassResponsibility
]

{ #category : #removing }
PureAbstractStackStrategy >> pop [
 	"Remove the object at the top of the stack and returns it.
 	 The implementation depends on the internal representation of the stack.
 	 Any subclass should implement this method properly."
 	^ self subclassResponsibility
]

{ #category : #adding }
PureAbstractStackStrategy >> push: newObject [
 	"Push newObject on the top of the stack.
 	 The implementation depends on the internal representation of the stack.
 	 Any subclass should implement this method properly."
 	self subclassResponsibility
]

{ #category : #initialization }
PureAbstractStackStrategy >> reset [
	"Reset the Stack. Removes all the object it used to contain."
	self subclassResponsibility
]

{ #category : #accessing }
PureAbstractStackStrategy >> size [
	"Returns the size of the stack."
 	^ self subclassResponsibility
]

{ #category : #accessing }
PureAbstractStackStrategy >> top [
 	"Returns the element at the top of the stack without removing it.
 	 The implementation depends on the internal representation of the stack.
 	 Any subclass should implement this method properly."
 	^ self subclassResponsibility
]
