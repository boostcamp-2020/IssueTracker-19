import React from 'react';
import { userService } from '@services';
import { useHistory } from 'react-router-dom';

export default function withAuth(InnerComponent) {
  const history = useHistory();

  const checkLogin = async () => {
    try {
      const { data, status } = await userService.checkLogin();
      if (status === 200) {
        // TODO : user 저장
      }
    } catch (err) {
      history.push('/login');
    }
  };

  useEffect(() => {
    checkLogin();
  }, []);

  return <InnerComponent />;
}
