// eslint-disable-next-line @typescript-eslint/no-unused-vars
const apiUri = window._env_.APP_REACT_API_URI;
const otra = window._env_.APP_REACT_OTRA;
export function App() {
  return (
    <div>
      API: {apiUri} OTRA:{otra}
    </div>
  );
}

export default App;
