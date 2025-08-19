import React from 'react';

// Test Case 1: Missing ARIA labels (should be flagged)
export const MissingAria = () => (
  <button className="bg-gray-600 text-white">
    Click me
  </button>
);

// Test Case 2: Small touch target (should be flagged)
export const SmallTouchTarget = () => (
  <button className="p-1 text-xs">
    Tiny button - VIOLATION (less than 40x40px)
  </button>
);

// Test Case 3: Missing focus states (should be flagged)
export const NoFocusState = () => (
  <input 
    type="text" 
    className="border border-gray-300"
    placeholder="No focus state defined"
  />
);

// Test Case 4: Poor contrast ratio (should be flagged)
export const PoorContrast = () => (
  <div className="bg-gray-200 text-gray-300">
    Low contrast text - VIOLATION
  </div>
);

// Test Case 5: Missing alt text (should be flagged)
export const MissingAlt = () => (
  <img src="/test.jpg" className="w-full h-auto" />
);