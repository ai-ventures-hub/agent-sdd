import React from 'react';

// Test Case 1: Hardcoded hex colors (should be flagged)
export const HardcodedColors = () => (
  <div style={{ backgroundColor: '#FF5733', color: '#333333' }}>
    Hardcoded hex colors - VIOLATION
  </div>
);

// Test Case 2: Non-approved Tailwind classes (should be flagged)
export const UnapprovedTailwind = () => (
  <button className="bg-purple-600 text-orange-300 hover:bg-pink-700">
    Unapproved color classes - VIOLATION
  </button>
);

// Test Case 3: Missing dark mode variants (should be flagged)
export const MissingDarkMode = () => (
  <div className="bg-gray-600 text-gray-900">
    Missing dark mode variants - VIOLATION
  </div>
);

// Test Case 4: Inline RGB colors (should be flagged)
export const InlineRGB = () => (
  <span style={{ color: 'rgb(255, 87, 51)' }}>
    RGB color usage - VIOLATION
  </span>
);

// Test Case 5: Mixed styling approaches (should be flagged)
export const MixedStyling = () => (
  <div 
    className="p-4" 
    style={{ margin: '10px', fontSize: '16px' }}
  >
    Mixed inline and utility classes - VIOLATION
  </div>
);